// package npc

import chisel3._
import chisel3.util._

// ----------------------
// Basic parameter/bundle infrastructure
// ----------------------
trait HasNPCParameter {
  // You can override these in your project-wide config if needed
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// ----------------------
// Minimal enums used by ISU
// (Adjust widths/values to match your project if already defined elsewhere)
// ----------------------
object FuSrcType {
  // match mapping described in the spec
  val rfSrc1 :: pc :: zero :: rfSrc2 :: imm :: four :: Nil = Enum(6)
  def apply(): UInt = UInt(3.W)
}

object FuType {
  val alu :: bru :: lsu :: csr :: mul :: div :: Nil = Enum(6)
  def apply(): UInt = UInt(3.W)
}

object FuOpType {
  val op0 :: op1 :: op2 :: op3 :: Nil = Enum(4)
  def apply(): UInt = UInt(2.W)
}

// ----------------------
// Bundles from spec
// ----------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt()         // left as-is per spec (unsized)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()
  val rs1        = UInt(5.W)
  val rs2        = UInt(5.W)
  val rfWen      = Bool()
  val rd         = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1        = UInt(XLen.W)
  val fuSrc2        = UInt(XLen.W)
  val imm           = UInt(XLen.W)

  val Alu0Res       = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata      = UInt(XLen.W)
  val rfSrc1        = UInt(XLen.W)
  val rfSrc2        = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

// ----------------------
// ScoreBoard (normal class, not a Module)
// ----------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val cntW = log2Ceil(maxScore + 1).max(1)
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(0) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)
        val cur   = busy(i)

        when(set && clear) {
          busy(i) := cur
        }.elsewhen(set) {
          when(cur =/= maxScore.U) { busy(i) := cur + 1.U }.otherwise { busy(i) := cur }
        }.elsewhen(clear) {
          when(cur =/= 0.U) { busy(i) := cur - 1.U }.otherwise { busy(i) := cur }
        }.otherwise {
          busy(i) := cur
        }
      }
    }
  }
}

// ----------------------
// ISU / dut
// ----------------------
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu   = Decoupled(new DecodeIO)
    val wb       = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // ----------------------
  // Helper: handshake deal (block transfer when invalidCondition asserted)
  // ----------------------
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    out.valid := in.valid && !invalidCond
    in.ready  := out.ready && !invalidCond
  }

  // ----------------------
  // Scoreboard instantiation
  // ----------------------
  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits

  // data hazard detect
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  // If your ISA has instructions where rs1/rs2 are not used, you should gate these.
  // Spec doesn’t define rs?_en, so we use simple (rs != 0) gating to avoid x0 false hazards.
  val hazard1 = (inBits.ctrl.rs1 =/= 0.U) && rs1Busy
  val hazard2 = (inBits.ctrl.rs2 =/= 0.U) && rs2Busy
  val AnyInvalidCondition = hazard1 || hazard2

  // default: pass-through all fields
  io.to_exu.bits := inBits

  // ----------------------
  // Regfile connection function
  // ----------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rf1, rf2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // ----------------------
  // Operand processing (fuSrc selection)
  // ----------------------
  val src1Sel = inBits.ctrl.fuSrc1Type
  val src2Sel = inBits.ctrl.fuSrc2Type

  val fuSrc1 = MuxLookup(src1Sel, rf1, Seq(
    FuSrcType.rfSrc1 -> rf1,
    FuSrcType.pc     -> inBits.cf.pc,
    FuSrcType.zero   -> 0.U(XLen.W)
  ))

  val fuSrc2 = MuxLookup(src2Sel, rf2, Seq(
    FuSrcType.rfSrc2 -> rf2,
    FuSrcType.imm    -> inBits.data.imm,
    FuSrcType.four   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2

  // Pass through Decoupled Alu0Res channel (no modification here)
  io.to_exu.bits.data.Alu0Res <> io.from_idu.bits.data.Alu0Res

  // ----------------------
  // Handshake control
  // ----------------------
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // ----------------------
  // Scoreboard update
  // - set when instruction issues (out.fire)
  // - clear when writeback indicates RegWrite
  // ----------------------
  val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
