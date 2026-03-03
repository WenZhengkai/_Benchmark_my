import chisel3._
import chisel3.util._

// Assumes these are already defined in your project:
// - HasNPCParameter, NPCBundle
// - DecodeIO, WbuToRegIO
// - FuSrcType / FuType / FuOpType enums and related constants

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntW = math.max(1, log2Ceil(maxScore + 1))
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && clearMask(i)) {
        busy(i) := busy(i)
      }.elsewhen(setMask(i)) {
        when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
      }.elsewhen(clearMask(i)) {
        when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
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

  val sb = new ScoreBoard(3)
  val inBits = io.from_idu.bits

  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], anyInvalidCondition: Bool): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready  := out.ready && !anyInvalidCondition
  }

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  // Default pass-through
  io.to_exu.bits := inBits

  // Regfile source hookup
  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Operand select
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.to_exu.bits.ctrl.fuSrc1Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1.asUInt -> rs1Val,
    FuSrcType.pc.asUInt     -> io.from_idu.bits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.to_exu.bits.ctrl.fuSrc2Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2.asUInt -> rs2Val,
    FuSrcType.imm.asUInt    -> io.from_idu.bits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  // Hazard detect (only check busy for register-based operands)
  val rs1Hazard = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) && sb.isBusy(inBits.ctrl.rs1)
  val rs2Hazard = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) && sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Hazard || rs2Hazard

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
