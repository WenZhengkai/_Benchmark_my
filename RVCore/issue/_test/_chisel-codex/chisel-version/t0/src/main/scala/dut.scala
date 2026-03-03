import chisel3._
import chisel3.util._

trait HasNPCParameter {
  val NR_GPR = 32
  val XLen   = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

trait HasStageConnect {
  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready  := out.ready && !anyInvalidCondition
  }
}

object FuType {
  def apply(): UInt = UInt(4.W)
}

object FuOpType {
  def apply(): UInt = UInt(8.W)
}

object FuSrcType {
  def apply(): UInt = UInt(3.W)

  // src1 selector
  val rfSrc1 = 0.U(3.W)
  val pc     = 1.U(3.W)
  val zero   = 2.U(3.W)

  // src2 selector
  val rfSrc2 = 0.U(3.W)
  val imm    = 1.U(3.W)
  val four   = 2.U(3.W)
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

class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 0)
  private val scoreW = math.max(1, log2Ceil(maxScore + 1))

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set   = setMask(i)
      val clear = clearMask(i)
      val inc   = Mux(busy(i) === maxScore.U, busy(i), busy(i) + 1.U)
      val dec   = Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)

      when(set && clear) {
        busy(i) := busy(i)
      }.elsewhen(set) {
        busy(i) := inc
      }.elsewhen(clear) {
        busy(i) := dec
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

class dut extends Module with HasNPCParameter with HasStageConnect {
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

  // Default pass-through
  io.to_exu.bits := inBits

  // regfile connection helper
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Operand select
  val op1 = MuxLookup(
    inBits.ctrl.fuSrc1Type,
    rs1Val,
    Seq(
      FuSrcType.rfSrc1 -> rs1Val,
      FuSrcType.pc     -> inBits.cf.pc,
      FuSrcType.zero   -> 0.U(XLen.W)
    )
  )

  val op2 = MuxLookup(
    inBits.ctrl.fuSrc2Type,
    rs2Val,
    Seq(
      FuSrcType.rfSrc2 -> rs2Val,
      FuSrcType.imm    -> inBits.data.imm,
      FuSrcType.four   -> 4.U(XLen.W)
    )
  )

  io.to_exu.bits.data.fuSrc1 := op1
  io.to_exu.bits.data.fuSrc2 := op2

  // Data hazard detect
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
