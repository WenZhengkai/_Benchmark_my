import chisel3._
import chisel3.util._

/** ScoreBoard used by ISU */
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val cntW   = log2Ceil(maxScore + 1).max(1)
  private val maxVal = maxScore.U(cntW.W)

  // busy(i) == 0 => register i is free
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U // x0 is always free
      } else {
        val set = setMask(i)
        val clr = clearMask(i)

        when(set && clr) {
          busy(i) := busy(i)
        }.elsewhen(set) {
          when(busy(i) =/= maxVal) { busy(i) := busy(i) + 1.U }
        }.elsewhen(clr) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
        }.otherwise {
          busy(i) := busy(i)
        }
      }
    }
  }
}

class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu   = Decoupled(new DecodeIO)
    val wb       = Input(new WbuToRegIO)

    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // local handshake helper (same behavior as requested HandShakeDeal)
  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    out.bits  := in.bits
    in.ready  := out.ready && !anyInvalid
  }

  // regfile connect helper
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val sb     = new ScoreBoard(3)
  val inBits = io.from_idu.bits

  // 1) data hazard detect
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // 5) pass DecodeIO first, then override generated fields
  io.to_exu.bits := inBits

  // 2) regfile values
  val (rf1, rf2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // 3) operand processing
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1 -> rf1,
    FuSrcType.pc     -> inBits.cf.pc,
    FuSrcType.zero   -> 0.U(XLen.W)
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2 -> rf2,
    FuSrcType.imm    -> inBits.data.imm,
    FuSrcType.four   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2

  // 4) scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
