import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int   = 64
}

class NPCBundle extends Bundle with HasNPCParameter

object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType {
  def apply(): UInt = UInt(4.W)
}
object FuOpType {
  def apply(): UInt = UInt(8.W)
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
  private val cntW = log2Ceil(maxScore + 1)
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U
      } else {
        val set = setMask(i)
        val clr = clearMask(i)
        when(set && clr) {
          busy(i) := busy(i)
        }.elsewhen(set) {
          when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
        }.elsewhen(clr) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
        }
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

  // Default full pass-through first.
  io.to_exu.bits := io.from_idu.bits

  // regfile connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Val, rs2Val) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  val inBits = io.from_idu.bits

  // Hazard check only when the operand actually reads RF.
  val rs1Hazard = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) && sb.isBusy(inBits.ctrl.rs1)
  val rs2Hazard = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) && sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Hazard || rs2Hazard

  // Operand processing
  val fuSrc1Sel = Wire(UInt(XLen.W))
  fuSrc1Sel := 0.U
  switch(inBits.ctrl.fuSrc1Type) {
    is(FuSrcType.rfSrc1) { fuSrc1Sel := rs1Val }
    is(FuSrcType.pc)     { fuSrc1Sel := inBits.cf.pc }
    is(FuSrcType.zero)   { fuSrc1Sel := 0.U }
  }

  val fuSrc2Sel = Wire(UInt(XLen.W))
  fuSrc2Sel := 0.U
  switch(inBits.ctrl.fuSrc2Type) {
    is(FuSrcType.rfSrc2) { fuSrc2Sel := rs2Val }
    is(FuSrcType.imm)    { fuSrc2Sel := inBits.data.imm }
    is(FuSrcType.four)   { fuSrc2Sel := 4.U }
  }

  io.to_exu.bits.data.fuSrc1 := fuSrc1Sel
  io.to_exu.bits.data.fuSrc2 := fuSrc2Sel

  // Handshake control
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready  := out.ready && !invalid
  }
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
