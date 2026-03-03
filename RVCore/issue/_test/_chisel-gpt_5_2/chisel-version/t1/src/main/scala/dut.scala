// package npc

import chisel3._
import chisel3.util._

// -----------------------------------------------------------------------------
// Common parameters / base bundle
// -----------------------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------------------------------------------------------
// Placeholder enums/types (adapt if your project already defines these)
// -----------------------------------------------------------------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType extends ChiselEnum {
  val alu, lsu, bru, csr, mul, div, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu, none = Value
}

// -----------------------------------------------------------------------------
// Bundles from the spec
// -----------------------------------------------------------------------------
class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W) // width unspecified in spec; choose a reasonable default
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

// -----------------------------------------------------------------------------
// ScoreBoard (class, not Module) per spec
// -----------------------------------------------------------------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val scoreW = log2Ceil(maxScore + 1)

  // busy counters (0 => free). busy(0) always 0.
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)

        when(set && clear) {
          busy(i) := busy(i) // keep
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

// -----------------------------------------------------------------------------
// Handshake helper
// Blocks transfer when AnyInvalidCondition is true.
// -----------------------------------------------------------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], block: Bool): Unit = {
    out.valid := in.valid && !block
    in.ready  := out.ready && !block
  }
}

// -----------------------------------------------------------------------------
// ISU: dut
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

  // Default connect pass-through
  io.to_exu.bits := io.from_idu.bits

  // Local alias
  val inBits  = io.from_idu.bits
  val outBits = io.to_exu.bits

  // ---------------------------------------------------------------------------
  // Regfile connection function
  // Directly assign rfSrc1/rfSrc2 into to_exu port signals; return rs1/rs2
  // ---------------------------------------------------------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    outBits.data.rfSrc1 := rfSrc1
    outBits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // ---------------------------------------------------------------------------
  // Data hazard detection (ScoreBoard)
  // ---------------------------------------------------------------------------
  val sb = new ScoreBoard(3)

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && (inBits.ctrl.rs1 =/= 0.U)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && (inBits.ctrl.rs2 =/= 0.U)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // ---------------------------------------------------------------------------
  // Operand processing / forwarding selection (as specified)
  // ---------------------------------------------------------------------------
  val fuSrc1Sel = Wire(UInt(XLen.W))
  val fuSrc2Sel = Wire(UInt(XLen.W))

  fuSrc1Sel := MuxLookup(
    inBits.ctrl.fuSrc1Type.asUInt,
    rs1Val,
    Array(
      FuSrcType.rfSrc1.asUInt -> rs1Val,
      FuSrcType.pc.asUInt     -> inBits.cf.pc,
      FuSrcType.zero.asUInt   -> 0.U(XLen.W)
    )
  )

  fuSrc2Sel := MuxLookup(
    inBits.ctrl.fuSrc2Type.asUInt,
    rs2Val,
    Array(
      FuSrcType.rfSrc2.asUInt -> rs2Val,
      FuSrcType.imm.asUInt    -> inBits.data.imm,
      FuSrcType.four.asUInt   -> 4.U(XLen.W)
    )
  )

  outBits.data.fuSrc1 := fuSrc1Sel
  outBits.data.fuSrc2 := fuSrc2Sel

  // ---------------------------------------------------------------------------
  // Scoreboard update
  // - set when instruction is issued (out.fire) and writes rd
  // - clear when WBU writes back
  // ---------------------------------------------------------------------------
  val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)

  // ---------------------------------------------------------------------------
  // Ensure Decoupled fields have safe defaults for any sub-Decoupled
  // (pass-through already done; still ensure Alu0Res handshake is defined)
  // ---------------------------------------------------------------------------
  // Default: pass-through the Alu0Res channel (if not used here)
  outBits.data.Alu0Res.valid := inBits.data.Alu0Res.valid
  outBits.data.Alu0Res.bits  := inBits.data.Alu0Res.bits
  inBits.data.Alu0Res.ready  := outBits.data.Alu0Res.ready
}
