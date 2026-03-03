// package npc

import chisel3._
import chisel3.util._

// ------------------------------------------------------------
// Common parameter / base bundle
// ------------------------------------------------------------
trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// ------------------------------------------------------------
// Minimal type defs (as in your project these are already defined)
// ------------------------------------------------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType extends ChiselEnum {
  val alu, bru, lsu, csr, mul, div, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu, none = Value
}

// ------------------------------------------------------------
// Bundles (per your description)
// ------------------------------------------------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt()         // left unspecified width in spec
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

// ------------------------------------------------------------
// ScoreBoard (normal class, not a Module)
// ------------------------------------------------------------
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntW = log2Ceil(maxScore + 1).max(1)
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    // one-hot, width NR_GPR
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
          when(cur =/= maxScore.U) { busy(i) := cur + 1.U } .otherwise { busy(i) := cur }
        }.elsewhen(clear) {
          when(cur =/= 0.U) { busy(i) := cur - 1.U } .otherwise { busy(i) := cur }
        }.otherwise {
          busy(i) := cur
        }
      }
    }
  }
}

// ------------------------------------------------------------
// ISU (dut)
// ------------------------------------------------------------
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

  // --------------------------
  // Scoreboard instance
  // --------------------------
  val sb = new ScoreBoard(3)

  // --------------------------
  // Convenience
  // --------------------------
  val inBits  = io.from_idu.bits
  val outBits = Wire(new DecodeIO)

  // Default: pass-through
  outBits := inBits

  // --------------------------
  // regfile connection function
  // --------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    // override outgoing rfSrc fields
    outBits.data.rfSrc1 := rfSrc1
    outBits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // --------------------------
  // Operand selection
  // --------------------------
  val src1 = MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1.asUInt -> rfSrc1,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  val src2 = MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2.asUInt -> rfSrc2,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  outBits.data.fuSrc1 := src1
  outBits.data.fuSrc2 := src2

  // Note: other DataSrc fields are passed through by default via outBits := inBits

  // --------------------------
  // Data hazard detection
  // --------------------------
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  // If a source register is busy, block issuing this instruction.
  // (You can refine with "uses rs1/rs2" gating if available in your decode.)
  val anyInvalidCondition = rs1Busy || rs2Busy

  // --------------------------
  // Handshake deal (simple combinational gating)
  // --------------------------
  io.to_exu.bits  := outBits
  io.to_exu.valid := io.from_idu.valid && !anyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !anyInvalidCondition

  // --------------------------
  // Scoreboard update
  // --------------------------
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
