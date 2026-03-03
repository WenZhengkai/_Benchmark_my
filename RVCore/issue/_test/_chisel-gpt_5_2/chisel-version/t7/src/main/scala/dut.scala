// package npc

import chisel3._
import chisel3.util._

// -----------------------------
// Common parameters / base bundle
// -----------------------------
trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------
// Simple enums (placeholders)
// -----------------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType extends ChiselEnum {
  val none = Value
}
object FuOpType extends ChiselEnum {
  val none = Value
}

// -----------------------------
// Given bundles (as described)
// -----------------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width unspecified in description
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

// -----------------------------
// ScoreBoard (as required)
// -----------------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
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
        busy(i) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)

        when(set && clear) {
          busy(i) := busy(i)
        }.elsewhen(set) {
          when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
            .otherwise { busy(i) := busy(i) }
        }.elsewhen(clear) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
            .otherwise { busy(i) := busy(i) }
        }.otherwise {
          busy(i) := busy(i)
        }
      }
    }
  }
}

// -----------------------------
// dut: Instruction Issue Unit (ISU)
// -----------------------------
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

  // ---------------------------
  // Helpers
  // ---------------------------
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }

  // regfile connection function (as required)
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  // ---------------------------
  // Default connections
  // ---------------------------
  io.to_exu.bits := 0.U.asTypeOf(new DecodeIO)

  val inBits = io.from_idu.bits
  io.to_exu.bits.cf   := inBits.cf
  io.to_exu.bits.ctrl := inBits.ctrl
  io.to_exu.bits.data := inBits.data

  // keep Decoupled in data bundle sane
  io.to_exu.bits.data.Alu0Res.valid := false.B
  io.to_exu.bits.data.Alu0Res.bits  := 0.U
  io.to_exu.bits.data.Alu0Res.ready := false.B

  // ---------------------------
  // Scoreboard + hazard detect
  // ---------------------------
  val sb = new ScoreBoard(3)

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // ---------------------------
  // Operand fetch/selection
  // ---------------------------
  val (rfSrc1Val, rfSrc2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  val src1 = MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1.asUInt -> rfSrc1Val,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  val src2 = MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2.asUInt -> rfSrc2Val,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := src1
  io.to_exu.bits.data.fuSrc2 := src2

  // ---------------------------
  // Scoreboard update
  // ---------------------------
  val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
