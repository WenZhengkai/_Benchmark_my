import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

object FuSrcType extends ChiselEnum {
  val rfSrc1, rfSrc2, pc, imm, zero, four = Value
}
object FuType extends ChiselEnum {
  val alu, lsu, bru, csr, mdu = Value
}
object FuOpType extends ChiselEnum {
  val none = Value
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
  private val cntW = log2Ceil(maxScore + 1).max(1)
  private val maxVal = maxScore.U(cntW.W)

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U
      } else {
        val set = setMask(i)
        val clr = clearMask(i)
        when(set && clr) {
          busy(i) := busy(i)
        }.elsewhen(set && !clr) {
          when(busy(i) =/= maxVal) { busy(i) := busy(i) + 1.U }
        }.elsewhen(!set && clr) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
        }
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

  private def HandShakeDeal[T <: Data](
      in: DecoupledIO[T],
      out: DecoupledIO[T],
      anyInvalidCondition: Bool
  ): Unit = {
    out.valid := in.valid && !anyInvalidCondition
    in.ready := out.ready && !anyInvalidCondition
  }

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits
  io.to_exu.bits := inBits

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val anyInvalidCondition = io.from_idu.valid && (rs1Busy || rs2Busy)

  HandShakeDeal(io.from_idu, io.to_exu, anyInvalidCondition)

  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  io.to_exu.bits.data.fuSrc1 := MuxCase(
    rfSrc1,
    Seq(
      (inBits.ctrl.fuSrc1Type === FuSrcType.pc) -> inBits.cf.pc,
      (inBits.ctrl.fuSrc1Type === FuSrcType.zero) -> 0.U(XLen.W)
    )
  )

  io.to_exu.bits.data.fuSrc2 := MuxCase(
    rfSrc2,
    Seq(
      (inBits.ctrl.fuSrc2Type === FuSrcType.imm) -> inBits.data.imm,
      (inBits.ctrl.fuSrc2Type === FuSrcType.four) -> 4.U(XLen.W)
    )
  )

  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask =
    Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
