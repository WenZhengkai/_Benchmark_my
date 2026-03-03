import chisel3._
import chisel3.util._

class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntW = log2Ceil(maxScore + 1)
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set  = setMask(i)
      val clr  = clearMask(i)
      val full = busy(i) === maxScore.U
      val zero = busy(i) === 0.U

      when(set && clr) {
        busy(i) := busy(i)
      }.elsewhen(set && !full) {
        busy(i) := busy(i) + 1.U
      }.elsewhen(clr && !zero) {
        busy(i) := busy(i) - 1.U
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

class dut(maxScore: Int = 3) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu   = Decoupled(new DecodeIO)
    val wb       = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = new ScoreBoard(maxScore)
  val inBits = io.from_idu.bits

  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], block: Bool): Unit = {
    out.valid := in.valid && !block
    in.ready  := out.ready && !block
  }

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  io.to_exu.bits := inBits
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  val rs1Busy = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) && sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) && sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  io.to_exu.bits.data.fuSrc1 := MuxCase(0.U(XLen.W), Seq(
    (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) -> rfSrc1,
    (inBits.ctrl.fuSrc1Type === FuSrcType.pc)     -> inBits.cf.pc,
    (inBits.ctrl.fuSrc1Type === FuSrcType.zero)   -> 0.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc2 := MuxCase(0.U(XLen.W), Seq(
    (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) -> rfSrc2,
    (inBits.ctrl.fuSrc2Type === FuSrcType.imm)    -> inBits.data.imm,
    (inBits.ctrl.fuSrc2Type === FuSrcType.four)   -> 4.U(XLen.W)
  ))

  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
