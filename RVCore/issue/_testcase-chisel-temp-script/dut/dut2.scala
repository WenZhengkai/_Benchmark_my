import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

object FuType {
  def apply(): UInt = UInt(3.W)
}

object FuOpType {
  def apply(): UInt = UInt(7.W)
}

object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(3.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)

  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntW = math.max(1, log2Ceil(maxScore + 1))
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)

  def mask(idx: UInt): UInt = UIntToOH(idx, NR_GPR)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clr = clearMask(i)
      when(set && clr) {
        busy(i) := busy(i) // keep unchanged
      }.elsewhen(set) {
        when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
      }.elsewhen(clr) {
        when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
      }
    }
  }
}

class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready := out.ready && !anyInvalidCondition
  }

  val sb = new ScoreBoard(3)
  val inBits = io.from_idu.bits
  val out = io.to_exu

  // Pass-through first, then override generated fields below
  out.bits := inBits

  // Optional same-cycle WB forwarding to operand reads
  val rs1Fwd = Mux(io.wb.RegWrite && (io.wb.rd =/= 0.U) && (io.wb.rd === inBits.ctrl.rs1), io.wb.Res, io.from_reg.rfSrc1)
  val rs2Fwd = Mux(io.wb.RegWrite && (io.wb.rd =/= 0.U) && (io.wb.rd === inBits.ctrl.rs2), io.wb.Res, io.from_reg.rfSrc2)

  // regfile connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    out.bits.data.rfSrc1 := rfSrc1
    out.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rs1Val, rs2Val) = rs1_rs2(rs1Fwd, rs2Fwd)

  // Operand select
  out.bits.data.fuSrc1 := MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1.asUInt -> rs1Val,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U(XLen.W)
  ))

  out.bits.data.fuSrc2 := MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2.asUInt -> rs2Val,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U(XLen.W)
  ))

  // Data hazard detection
  val rs1Need = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val rs2Need = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  val anyInvalidCondition = (rs1Need && sb.isBusy(inBits.ctrl.rs1)) || (rs2Need && sb.isBusy(inBits.ctrl.rs2))

  // Handshake control
  HandShakeDeal(io.from_idu, out, anyInvalidCondition)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
