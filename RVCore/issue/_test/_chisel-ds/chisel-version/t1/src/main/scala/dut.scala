import chisel3._
import chisel3.util._

// Define the NPCBundle which will be extended by other bundles
class NPCBundle extends Bundle {
  // Add common fields if needed
}

// Define the WbuToRegIO bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// Define the DecodeIO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the CtrlFlow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Define the CtrlSignal bundle
class CtrlSignal extends NPCBundle {
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

// Define the ScoreBoard module
class ScoreBoard(maxScore: Int, NR_GPR: Int) extends Module {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(5.W))
    val mask = Input(UInt(5.W))
    val update = Input(new Bundle {
      val setMask = UInt(NR_GPR.W)
      val clearMask = UInt(NR_GPR.W)
    })
    val busy = Output(Vec(NR_GPR, UInt(log2Ceil(maxScore + 1).W)))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  def mask(idx: UInt): UInt = {
    (1.U << idx)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && !clearMask(i)) {
        busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
      }.elsewhen(!setMask(i) && clearMask(i)) {
        busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }

  io.busy := busy
}

// Define the ISU module
class ISU(maxScore: Int, NR_GPR: Int, XLen: Int) extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(maxScore, NR_GPR))

  val AnyInvalidCondition = sb.io.isBusy(io.from_idu.bits.ctrl.rs1) || sb.io.isBusy(io.from_idu.bits.ctrl.rs2)

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  io.to_exu.bits.cf := io.from_idu.bits.cf
  io.to_exu.bits.ctrl := io.from_idu.bits.ctrl
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

  io.to_exu.valid := io.from_idu.valid && !AnyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !AnyInvalidCondition
}

// Define the FuSrcType enumeration
object FuSrcType extends Enumeration {
  type FuSrcType = Value
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

// Define the FuType enumeration
object FuType extends Enumeration {
  type FuType = Value
  val ALU, MEM, CSR = Value
}

// Define the FuOpType enumeration
object FuOpType extends Enumeration {
  type FuOpType = Value
  val ADD, SUB, AND, OR, XOR = Value
}

// Main object to generate the Verilog code
/*
object ISU extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new ISU(3, 32, 64), args)
}
*/
