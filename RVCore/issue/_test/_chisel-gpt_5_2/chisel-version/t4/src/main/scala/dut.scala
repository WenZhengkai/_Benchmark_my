// package npc

import chisel3._
import chisel3.util._

/** ---------------------------------------------------------------------------
  * Minimal infrastructure (parameter/bundle base)
  * ---------------------------------------------------------------------------
  */
trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen:  Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

/** ---------------------------------------------------------------------------
  * Enumerations (as Chisel UInt "enums")
  * ---------------------------------------------------------------------------
  */
object FuSrcType {
  // keep width small but sufficient
  val width = 3
  def apply(): UInt = UInt(width.W)

  val rfSrc1 :: pc :: zero :: rfSrc2 :: imm :: four :: Nil = Enum(6)
}

object FuType {
  val width = 3
  def apply(): UInt = UInt(width.W)
}

object FuOpType {
  val width = 6
  def apply(): UInt = UInt(width.W)
}

/** ---------------------------------------------------------------------------
  * Bundles
  * ---------------------------------------------------------------------------
  */
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // left unconstrained as in description
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

/** ---------------------------------------------------------------------------
  * ScoreBoard (normal class, not a Module)
  * ---------------------------------------------------------------------------
  */
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val cntW = log2Ceil(maxScore + 1).max(1)

  // busy(i) is a small counter. busy(0) is always 0.
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = {
    // x0 is never busy
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    // 1 << idx, width NR_GPR
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(0) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)

        when(set && clear) {
          busy(i) := busy(i)
        }.elsewhen(set) {
          when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
        }.elsewhen(clear) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
        }.otherwise {
          busy(i) := busy(i)
        }
      }
    }
  }
}

/** ---------------------------------------------------------------------------
  * ISU (dut)
  * ---------------------------------------------------------------------------
  */
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu  = Flipped(Decoupled(new DecodeIO))
    val to_exu    = Decoupled(new DecodeIO)
    val wb        = Input(new WbuToRegIO)

    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  /** Handshake helper:
    * - When invalidCond is true, block transfer (out.valid=0, in.ready=0)
    * - Otherwise pass through (out.valid=in.valid, in.ready=out.ready)
    */
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    when(invalidCond) {
      out.valid := false.B
      in.ready  := false.B
    }.otherwise {
      out.valid := in.valid
      in.ready  := out.ready
    }
  }

  val sb = new ScoreBoard(3)

  val inBits  = io.from_idu.bits
  val outBits = io.to_exu.bits

  /** Data hazard detection */
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  // Only consider hazards when actually using those sources:
  // fuSrc1Type==rfSrc1 consumes rs1; fuSrc2Type==rfSrc2 consumes rs2
  val useRs1 = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val useRs2 = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2

  val AnyInvalidCondition = (useRs1 && rs1Busy) || (useRs2 && rs2Busy)

  /** Connect base path IDU -> EXU (bundle-wide), then override some fields */
  outBits := inBits

  /** Regfile connection function */
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    // drive rfSrc fields toward EXU
    outBits.data.rfSrc1 := rfSrc1
    outBits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  /** Operand processing */
  val fuSrc1Val = MuxLookup(
    inBits.ctrl.fuSrc1Type,
    rs1Val, // default
    Seq(
      FuSrcType.rfSrc1 -> rs1Val,
      FuSrcType.pc     -> inBits.cf.pc,
      FuSrcType.zero   -> 0.U(XLen.W)
    )
  )

  val fuSrc2Val = MuxLookup(
    inBits.ctrl.fuSrc2Type,
    rs2Val, // default
    Seq(
      FuSrcType.rfSrc2 -> rs2Val,
      FuSrcType.imm    -> inBits.data.imm,
      FuSrcType.four   -> 4.U(XLen.W)
    )
  )

  outBits.data.fuSrc1 := fuSrc1Val
  outBits.data.fuSrc2 := fuSrc2Val

  /** Alu0Res is a Decoupled in DecodeIO; not produced here.
    * Keep it non-blocking by default.
    */
  outBits.data.Alu0Res.valid := false.B
  outBits.data.Alu0Res.bits  := 0.U
  io.from_idu.bits.data.Alu0Res.ready := true.B // safe default (not used by this ISU)

  /** Handshake */
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  /** Scoreboard update */
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
