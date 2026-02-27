import chisel3._
import chisel3.util._

// Define the NPCBundle trait
trait NPCBundle extends Bundle {
  val XLen: Int
}

// Define the HasNPCParameter trait
trait HasNPCParameter {
  val NR_GPR: Int
  val XLen: Int
}

// Define the WbuToRegIO bundle
class WbuToRegIO(implicit val p: HasNPCParameter) extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(p.XLen.W)
  val RegWrite = Bool()
}

// Define the CtrlFlow bundle
class CtrlFlow(implicit val p: HasNPCParameter) extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(p.XLen.W)
  val next_pc = UInt(p.XLen.W)
  val isBranch = Bool()
}

// Define the FuSrcType and FuType enums
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

object FuType extends ChiselEnum {
  val ALU, MEM, CSR = Value
}

object FuOpType extends ChiselEnum {
  val ADD, SUB, AND, OR, XOR = Value
}

// Define the CtrlSignal bundle
class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define the DataSrc bundle
class DataSrc(implicit val p: HasNPCParameter) extends NPCBundle {
  val fuSrc1 = UInt(p.XLen.W)
  val fuSrc2 = UInt(p.XLen.W)
  val imm = UInt(p.XLen.W)
  val Alu0Res = Decoupled(UInt(p.XLen.W))
  val data_from_mem = UInt(p.XLen.W)
  val csrRdata = UInt(p.XLen.W)
  val rfSrc1 = UInt(p.XLen.W)
  val rfSrc2 = UInt(p.XLen.W)
}

// Define the DecodeIO bundle
class DecodeIO(implicit val p: HasNPCParameter) extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the ScoreBoard module
class ScoreBoard(maxScore: Int)(implicit val p: HasNPCParameter) extends Module {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(5.W))
    val mask = Input(UInt(5.W))
    val setMask = Input(UInt(p.NR_GPR.W))
    val clearMask = Input(UInt(p.NR_GPR.W))
    val update = Output(UInt(p.NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(p.NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  def mask(idx: UInt): UInt = {
    (1.U << idx).asUInt()
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until p.NR_GPR) {
      when(setMask(i) && !clearMask(i)) {
        busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
      }.elsewhen(!setMask(i) && clearMask(i)) {
        busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      }
    }
  }

  io.update := busy.asUInt()
}

// Define the ISU module
class ISU(maxScore: Int)(implicit val p: HasNPCParameter) extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(p.XLen.W))
      val rfSrc2 = Input(UInt(p.XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(maxScore))

  val AnyInvalidCondition = sb.io.isBusy(io.from_idu.bits.ctrl.rs1) || sb.io.isBusy(io.from_idu.bits.ctrl.rs2)

  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], cond: Bool): Unit = {
    out.valid := in.valid && !cond
    in.ready := out.ready && !cond
  }

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  io.to_exu.bits := io.from_idu.bits
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)
}

// Main object to generate the Verilog code
/*
object ISU extends App {
  implicit val p = new HasNPCParameter {
    val NR_GPR = 32
    val XLen = 64
  }
  (new chisel3.stage.ChiselStage).emitVerilog(new ISU(3), Array("--target-dir", "generated"))
}
*/
