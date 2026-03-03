import chisel3._
import chisel3.util._

class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  private val scoreW = log2Ceil(maxScore + 1).max(1)

  // busy(0) is always zero register, never busy
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val setI = setMask(i)
      val clrI = clearMask(i)

      when(setI && clrI) {
        busy(i) := busy(i)
      }.elsewhen(setI) {
        busy(i) := Mux(busy(i) === maxScore.U, busy(i), busy(i) + 1.U)
      }.elsewhen(clrI) {
        busy(i) := Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

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

  private def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready  := out.ready && !anyInvalidCondition
  }

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits
  val outBits = Wire(new DecodeIO)
  outBits := inBits

  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Hazard detect
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Operand select
  outBits.data.fuSrc1 := MuxLookup(
    inBits.ctrl.fuSrc1Type.asUInt,
    rfSrc1,
    Seq(
      FuSrcType.rfSrc1.asUInt -> rfSrc1,
      FuSrcType.pc.asUInt     -> inBits.cf.pc,
      FuSrcType.zero.asUInt   -> 0.U(XLen.W)
    )
  )

  outBits.data.fuSrc2 := MuxLookup(
    inBits.ctrl.fuSrc2Type.asUInt,
    rfSrc2,
    Seq(
      FuSrcType.rfSrc2.asUInt -> rfSrc2,
      FuSrcType.imm.asUInt    -> inBits.data.imm,
      FuSrcType.four.asUInt   -> 4.U(XLen.W)
    )
  )

  // Pass through + override generated fields
  outBits.data.rfSrc1 := rfSrc1
  outBits.data.rfSrc2 := rfSrc2

  io.to_exu.bits := outBits

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
