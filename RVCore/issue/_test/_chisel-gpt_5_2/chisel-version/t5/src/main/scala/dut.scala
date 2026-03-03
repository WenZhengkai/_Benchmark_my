// package npc

import chisel3._
import chisel3.util._

// -----------------------------------------------------------------------------
// Basic parameters / base bundle
// -----------------------------------------------------------------------------
trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------------------------------------------------------
// Minimal enum-like definitions (so this file is self-contained)
// -----------------------------------------------------------------------------
object FuSrcType {
  // Src1 types
  val rfSrc1 :: pc :: zero :: Nil = Enum(3)
  // Src2 types
  val rfSrc2 :: imm :: four :: Nil = Enum(3)
  def apply(): UInt = UInt(2.W)
}
object FuType {
  val dummy :: Nil = Enum(1)
  def apply(): UInt = UInt(1.W)
}
object FuOpType {
  val dummy :: Nil = Enum(1)
  def apply(): UInt = UInt(1.W)
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
// ScoreBoard (normal class, not a Module)
// -----------------------------------------------------------------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  private val scoreW = log2Ceil(maxScore + 1).max(1)

  // busy(i) = 0 => not busy; >0 => busy
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  // setMask/clearMask: NR_GPR-bit masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(0) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)

        when(set && clear) {
          busy(i) := busy(i) // keep
        }.elsewhen(set) {
          when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }.otherwise { busy(i) := busy(i) }
        }.elsewhen(clear) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }.otherwise { busy(i) := 0.U }
        }.otherwise {
          busy(i) := busy(i)
        }
      }
    }
  }
}

// -----------------------------------------------------------------------------
// dut (ISU)
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

  // ---------------------------------------------------------------------------
  // Handshake helper: block transfer when invalidCond is true
  // ---------------------------------------------------------------------------
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    out.valid := in.valid && !invalidCond
    in.ready  := out.ready && !invalidCond
  }

  // ---------------------------------------------------------------------------
  // Scoreboard
  // ---------------------------------------------------------------------------
  val sb = new ScoreBoard(3)

  val inBits  = io.from_idu.bits
  val outBits = io.to_exu.bits

  // Hazard detection (sources busy => block)
  val rs1Busy = (inBits.ctrl.rs1 =/= 0.U) && sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = (inBits.ctrl.rs2 =/= 0.U) && sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Apply handshake gating
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // ---------------------------------------------------------------------------
  // Pass-through default connection
  // ---------------------------------------------------------------------------
  outBits := inBits

  // ---------------------------------------------------------------------------
  // regfile connection function (and override rfSrc1/rfSrc2 fields to EXU)
  // ---------------------------------------------------------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rfSrc1Val, rfSrc2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // ---------------------------------------------------------------------------
  // Operand processing (generate fuSrc1 / fuSrc2)
  // ---------------------------------------------------------------------------
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, rfSrc1Val, Seq(
    FuSrcType.rfSrc1 -> rfSrc1Val,
    FuSrcType.pc     -> inBits.cf.pc,
    FuSrcType.zero   -> 0.U(XLen.W)
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, rfSrc2Val, Seq(
    FuSrcType.rfSrc2 -> rfSrc2Val,
    FuSrcType.imm    -> inBits.data.imm,
    FuSrcType.four   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2

  // ---------------------------------------------------------------------------
  // Scoreboard update:
  // - set when instruction issues (out.fire) and it writes rd
  // - clear when wb completes
  // ---------------------------------------------------------------------------
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)

  // ---------------------------------------------------------------------------
  // Ensure the internal Decoupled inside DataSrc is driven (pass-through)
  // (Already covered by outBits := inBits; keep explicit for clarity.)
  // ---------------------------------------------------------------------------
  io.to_exu.bits.data.Alu0Res <> io.from_idu.bits.data.Alu0Res
}
