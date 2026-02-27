// package npc

import chisel3._
import chisel3.util._

// Instruction Issue Unit with Scoreboard
class ISU extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Create the scoreboard for register tracking
  val sb = new ScoreBoard(3)

  // Prepare the input/output signals for easier reference
  val in = io.from_idu
  val out = io.to_exu
  val inBits = in.bits

  // Connect most signals directly from input to output
  out.bits := inBits

  // Determine if there are any hazards that should block issue
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1 && inBits.ctrl.rs1 =/= 0.U
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2 && inBits.ctrl.rs2 =/= 0.U
  val rdConflict = inBits.ctrl.rfWen && (
    (inBits.ctrl.rd === inBits.ctrl.rs1 && inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1 && inBits.ctrl.rs1 =/= 0.U) ||
    (inBits.ctrl.rd === inBits.ctrl.rs2 && inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2 && inBits.ctrl.rs2 =/= 0.U)
  )
  val AnyInvalidCondition = rs1Busy || rs2Busy || rdConflict

  // Process source operands
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Select appropriate operands based on control signals
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U)(Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U)(Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Override operand values in the output
  out.bits.data.fuSrc1 := fuSrc1
  out.bits.data.fuSrc2 := fuSrc2
  out.bits.data.rfSrc1 := rfSrc1
  out.bits.data.rfSrc2 := rfSrc2

  // Handshake control based on hazard detection
  HandShakeDeal(in, out, AnyInvalidCondition)

  // Update scoreboard - set mask when issuing an instruction with destination register
  // clear mask when write back is completed
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Helper function for handling register source values
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    val rs1 = rfSrc1
    val rs2 = rfSrc2
    (rs1, rs2)
  }

  // Helper function for handshake control
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], block: Bool): Unit = {
    out.valid := in.valid && !block
    in.ready := out.ready && !block
  }
}

// Scoreboard for tracking register usage
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Register busy counters
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U((log2Ceil(maxScore) + 1).W))))

  // Check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) > 0.U
  }

  // Generate a mask for the specified register
  def mask(idx: UInt): UInt = {
    val mask = Wire(UInt(NR_GPR.W))
    mask := (1.U(NR_GPR.W) << idx)
    mask
  }

  // Update the scoreboard based on set and clear masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      val doSet = (setMask & (1.U << i.U)).orR
      val doClear = (clearMask & (1.U << i.U)).orR
      val value = busy(i)

      busy(i) := MuxCase(value, Seq(
        // Keep original value when both set and clear
        (doSet && doClear) -> value,
        // Increment counter (with limit)
        doSet -> Mux(value === maxScore.U, value, value + 1.U),
        // Decrement counter (with limit)
        doClear -> Mux(value === 0.U, 0.U, value - 1.U)
      ))
    }
    // Register 0 is always free
    busy(0) := 0.U
  }
}

// Control signals and data types
object FuSrcType extends ChiselEnum {
  val rfSrc1, rfSrc2, pc, imm, zero, four = Value
}

object FuType extends ChiselEnum {
  val alu, bru, lsu, mdu, csr = Value
}

object FuOpType extends ChiselEnum {
  val add, sub, sll, slt, sltu, xor, srl, sra, or, and, addw, subw, sllw, srlw, sraw = Value
  val beq, bne, blt, bge, bltu, bgeu = Value
  val lb, lh, lw, ld, lbu, lhu, lwu, sb, sh, sw, sd = Value
  val mul, mulh, mulhsu, mulhu, div, divu, rem, remu, mulw, divw, divuw, remw, remuw = Value
  val csrrw, csrrs, csrrc, csrrwi, csrrsi, csrrci = Value
}

// Required base trait and bundles
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

trait NPCModule extends Module with HasNPCParameter
trait NPCBundle extends Bundle with HasNPCParameter

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}
