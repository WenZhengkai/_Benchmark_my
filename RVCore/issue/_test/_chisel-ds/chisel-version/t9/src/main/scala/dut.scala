import chisel3._
import chisel3.util._

// Define the NPCBundle trait, which all bundles inherit from
trait NPCBundle extends Bundle {
  val XLen: Int = 32 // Default data bit width
}

// Define the HasNPCParameter trait, which provides parameters
trait HasNPCParameter {
  val NR_GPR: Int = 32 // Number of general-purpose registers
  val XLen: Int = 32   // Data bit width
}

// Define the WbuToRegIO bundle
class WbuToRegIO extends NPCBundle {
  val rd = Output(UInt(5.W))
  val Res = Output(UInt(XLen.W))
  val RegWrite = Output(Bool())
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
  val ResSrc = UInt(2.W)
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

// Define the FuSrcType and FuType enumerations
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

object FuType extends ChiselEnum {
  val alu, mem, csr = Value
}

object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor = Value
}

// Define the ScoreBoard module
class ScoreBoard(maxScore: Int)(implicit val p: HasNPCParameter) extends Module {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(p.NR_GPR.W))
    val mask = Input(UInt(p.NR_GPR.W))
    val update = Input(new Bundle {
      val setMask = UInt(p.NR_GPR.W)
      val clearMask = UInt(p.NR_GPR.W)
    })
  })

  val busy = RegInit(VecInit(Seq.fill(p.NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  def mask(idx: UInt): UInt = {
    (1.U << idx).asUInt
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

  // Instantiate the ScoreBoard
  val sb = Module(new ScoreBoard(maxScore))

  // Data hazard detection
  val rs1Busy = sb.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.isBusy(io.from_idu.bits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handle handshake signal
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready && !invalid
  }

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Register file connection function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Connect output
  io.to_exu.bits <> io.from_idu.bits
}

// Top-level module
class dut(maxScore: Int)(implicit val p: HasNPCParameter) extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(p.XLen.W))
      val rfSrc2 = Input(UInt(p.XLen.W))
    }
  })

  val isu = Module(new ISU(maxScore))
  io.from_idu <> isu.io.from_idu
  io.to_exu <> isu.io.to_exu
  io.wb <> isu.io.wb
  io.from_reg <> isu.io.from_reg
}

// Main object to generate Verilog
/*
object dut extends App {
  implicit val p: HasNPCParameter = new HasNPCParameter {}
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(3), Array("--target-dir", "generated"))
}
*/
