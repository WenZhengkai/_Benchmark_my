import chisel3._
import chisel3.util._

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val scoreW = log2Ceil(maxScore + 1).max(1)
  private val maxCnt = maxScore.U(scoreW.W)

  // One counter per GPR; busy(0) is always zero.
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set   = setMask(i)
      val clear = clearMask(i)

      when(set && clear) {
        busy(i) := busy(i) // hold
      }.elsewhen(set && !clear) {
        when(busy(i) =/= maxCnt) {
          busy(i) := busy(i) + 1.U
        }
      }.elsewhen(!set && clear) {
        when(busy(i) =/= 0.U) {
          busy(i) := busy(i) - 1.U
        }
      }.otherwise {
        busy(i) := busy(i) // hold
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

  // Handshake helper required by spec.
  private def HandShakeDeal[T <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[T],
    anyInvalidCondition: Bool
  ): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready  := out.ready && !anyInvalidCondition
  }

  // 1) Scoreboard and hazard detection
  val sb = new ScoreBoard(3)
  val inBits = io.from_idu.bits

  val rs1NeedHazardCheck = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val rs2NeedHazardCheck = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2

  val rs1Busy = rs1NeedHazardCheck && sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = rs2NeedHazardCheck && sb.isBusy(inBits.ctrl.rs2)

  val AnyInvalidCondition = rs1Busy || rs2Busy

  // 2) Pass through DecodeIO first, then override generated fields
  io.to_exu.bits := inBits

  // 3) regfile connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Data, rs2Data) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // 4) Operand processing
  val fuSrc1Sel = MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, rs1Data, Seq(
    FuSrcType.rfSrc1.asUInt -> rs1Data,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  val fuSrc2Sel = MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, rs2Data, Seq(
    FuSrcType.rfSrc2.asUInt -> rs2Data,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := fuSrc1Sel
  io.to_exu.bits.data.fuSrc2 := fuSrc2Sel

  // 5) Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // 6) Scoreboard update
  val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
