// package npc

import chisel3._
import chisel3.util._

// -----------------------------------------------------------------------------
// Minimal infrastructure (so this file is self-contained).
// If you already have these in your project, you can delete these definitions.
// -----------------------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int  = 64
  val NR_GPR: Int = 32
}
abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------------------------------------------------------
// Enumerations used by DecodeIO
// -----------------------------------------------------------------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType extends ChiselEnum {
  val none = Value
}
object FuOpType extends ChiselEnum {
  val none = Value
}

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
  val ResSrc     = UInt() // width unspecified in description; keep as-is
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
// ScoreBoard (normal class; holds registers via chisel RegInit)
// -----------------------------------------------------------------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  private val cntW = log2Ceil(maxScore + 1).max(1)
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    // x0 always not busy
    busy(0) := 0.U

    for (i <- 1 until NR_GPR) {
      val set   = setMask(i)
      val clear = clearMask(i)

      when(set && clear) {
        busy(i) := busy(i) // keep
      }.elsewhen(set) {
        when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
          .otherwise { busy(i) := busy(i) }
      }.elsewhen(clear) {
        when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
          .otherwise { busy(i) := 0.U }
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

// -----------------------------------------------------------------------------
// dut: Instruction Issue Unit (ISU)
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

  // -------------------------
  // Handshake helper
  // -------------------------
  private def HandShakeDeal(in: DecoupledIO[DecodeIO],
                            out: DecoupledIO[DecodeIO],
                            anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }

  // -------------------------
  // Scoreboard / hazard detect
  // -------------------------
  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && (inBits.ctrl.rs1 =/= 0.U)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && (inBits.ctrl.rs2 =/= 0.U)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Default bulk connection (will override selected data fields below)
  io.to_exu.bits := inBits

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // -------------------------
  // regfile connection function
  // -------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // -------------------------
  // Operand processing
  // -------------------------
  val src1 = MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, rfSrc1, Seq(
    FuSrcType.rfSrc1.asUInt -> rfSrc1,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  val src2 = MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, rfSrc2, Seq(
    FuSrcType.rfSrc2.asUInt -> rfSrc2,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := src1
  io.to_exu.bits.data.fuSrc2 := src2

  // -------------------------
  // Scoreboard update (set on issue, clear on WB)
  // -------------------------
  val outFire = io.to_exu.fire

  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && outFire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
