// package npc

import chisel3._
import chisel3.util._

// -----------------------------------------------------------------------------
// Minimal infrastructure (parameters / base bundle)
// -----------------------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------------------------------------------------------
// Placeholder enum-like objects for source/type selections
// (Sized to be synthesizable; adapt widths/encodings to your real design.)
// -----------------------------------------------------------------------------
object FuSrcType {
  // 3-bit encoding
  def apply(): UInt = UInt(3.W)
  val rfSrc1 = 0.U(3.W)
  val pc     = 1.U(3.W)
  val zero   = 2.U(3.W)

  val rfSrc2 = 3.U(3.W)
  val imm    = 4.U(3.W)
  val four   = 5.U(3.W)
}
object FuType    { def apply(): UInt = UInt(3.W) }
object FuOpType  { def apply(): UInt = UInt(4.W) }

// -----------------------------------------------------------------------------
// Bundles (as described)
// -----------------------------------------------------------------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)
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

// -----------------------------------------------------------------------------
// ScoreBoard (normal class; internal registers created inside update())
// -----------------------------------------------------------------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  private val scoreW = log2Ceil(maxScore + 1).max(1)

  // Busy counters for each GPR
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    // onehot within NR_GPR bits; idx=0 still produces bit0=1, but busy(0) is forced to 0 in update()
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(0) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)

        val cur = busy(i)
        val inc = Mux(cur === maxScore.U, cur, cur + 1.U)
        val dec = Mux(cur === 0.U, cur, cur - 1.U)

        when(set && clear) {
          busy(i) := cur
        }.elsewhen(set) {
          busy(i) := inc
        }.elsewhen(clear) {
          busy(i) := dec
        }.otherwise {
          busy(i) := cur
        }
      }
    }
  }
}

// -----------------------------------------------------------------------------
// Handshake helper
// - Block downstream valid when AnyInvalidCondition is true
// - Backpressure to upstream accordingly
// -----------------------------------------------------------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }
}

// -----------------------------------------------------------------------------
// ISU dut
// -----------------------------------------------------------------------------
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

  // Default pass-through
  io.to_exu.bits := io.from_idu.bits

  // ----------------------------
  // Scoreboard / hazard detect
  // ----------------------------
  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  // Simple RAW hazard block (customize with "uses-rs" qualifiers if needed)
  val anyInvalidCondition = rs1Busy || rs2Busy

  // Handshake
  HandShakeDeal(io.from_idu, io.to_exu, anyInvalidCondition)

  // ----------------------------
  // Regfile connection function
  // ----------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rf1, rf2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // ----------------------------
  // Operand processing
  // ----------------------------
  val src1 = MuxLookup(inBits.ctrl.fuSrc1Type, rf1, Seq(
    FuSrcType.rfSrc1 -> rf1,
    FuSrcType.pc     -> inBits.cf.pc,
    FuSrcType.zero   -> 0.U(XLen.W)
  ))

  val src2 = MuxLookup(inBits.ctrl.fuSrc2Type, rf2, Seq(
    FuSrcType.rfSrc2 -> rf2,
    FuSrcType.imm    -> inBits.data.imm,
    FuSrcType.four   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := src1
  io.to_exu.bits.data.fuSrc2 := src2

  // Keep Alu0Res channel pass-through by default (already via bits :=)
  // but ensure its ready is driven by downstream if required:
  // (Decoupled field inside bits typically should be driven by consumer;
  // leaving as-is from pass-through is usually correct in a simple pipeline.)

  // ----------------------------
  // Scoreboard update
  // ----------------------------
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
