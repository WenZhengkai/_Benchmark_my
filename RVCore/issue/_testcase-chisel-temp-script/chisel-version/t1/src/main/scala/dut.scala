import chisel3._
import chisel3.util._

// -----------------------------------------------------------------------------
// Basic project-level definitions (self-contained)
// -----------------------------------------------------------------------------
trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

object FuType {
  def apply(): UInt = UInt(4.W)
}

object FuOpType {
  def apply(): UInt = UInt(8.W)
}

// -----------------------------------------------------------------------------
// Bundles
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
  val ResSrc     = UInt(3.W)
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
// ScoreBoard (class, not Module)
// -----------------------------------------------------------------------------
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val cntWidth = log2Ceil(maxScore + 1).max(1)
  private val maxCnt   = maxScore.U(cntWidth.W)

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntWidth.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR).asUInt

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clr = clearMask(i)

      when(set && clr) {
        busy(i) := busy(i) // keep when set & clear together
      }.elsewhen(set && !clr) {
        when(busy(i) =/= maxCnt) { busy(i) := busy(i) + 1.U }
      }.elsewhen(!set && clr) {
        when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
      }
    }
  }
}

// -----------------------------------------------------------------------------
// ISU module: dut
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

  val sb     = new ScoreBoard(3)
  val inBits = io.from_idu.bits
  val out    = io.to_exu

  // Default pass-through first
  out.bits := inBits

  // 1) Data hazard detection
  val rs1Busy = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) && sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) && sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake control
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready  := out.ready && !invalid
  }
  HandShakeDeal(io.from_idu, out, AnyInvalidCondition)

  // 2) regfile connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    out.bits.data.rfSrc1 := rfSrc1
    out.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // 3) Operand processing
  val fuSrc1Sel = MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, rs1Val, Seq(
    FuSrcType.rfSrc1.asUInt -> rs1Val,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  val fuSrc2Sel = MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, rs2Val, Seq(
    FuSrcType.rfSrc2.asUInt -> rs2Val,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  out.bits.data.fuSrc1 := fuSrc1Sel
  out.bits.data.fuSrc2 := fuSrc2Sel

  // 4) Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
