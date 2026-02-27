import chisel3._
import chisel3.util._

// Define common bundles and parameters
class NPCBundle extends Bundle {
  // Add common fields if needed
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

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

// Define module parameters and types
trait HasNPCParameter {
  val XLen = 32
  val NR_GPR = 32
}

object FuSrcType extends HasNPCParameter {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

object FuType extends HasNPCParameter {
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = "b101".U
  def apply() = UInt(log2Up(5).W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

trait TYPE_INST {
  def TYPE_N = "b0000".U
  def TYPE_I = "b0100".U
  def TYPE_R = "b0101".U
  def TYPE_S = "b0010".U
  def TYPE_B = "b0001".U
  def TYPE_U = "b0110".U
  def TYPE_J = "b0111".U
  def isRegWrite(instType: UInt): Bool = instType(2, 2) === 1.U
}

// IFU Module
class IFU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit(0x80000000.U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // PC update logic
  when(io.redirect.valid) {
    nextPc := io.redirect.target
  }.otherwise {
    nextPc := pcReg + 4.U
  }

  pcReg := nextPc
  io.pc := pcReg

  // Output control flow
  io.to_idu.valid := true.B
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
}

// IDU Module
class IDU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake logic
  io.to_isu <> io.from_ifu

  // Decode logic (simplified)
  val instType = Wire(UInt(4.W))
  val fuType = Wire(UInt(3.W))
  val fuOpType = Wire(UInt(7.W))
  val fuSrc1Type = Wire(UInt(3.W))
  val fuSrc2Type = Wire(UInt(3.W))

  // Default decode values
  instType := "b0000".U
  fuType := FuType.alu
  fuOpType := 0.U
  fuSrc1Type := FuSrcType.rfSrc1
  fuSrc2Type := FuSrcType.rfSrc2

  // Immediate extension (simplified)
  val imm = Wire(UInt(XLen.W))
  imm := 0.U

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.MemWrite := false.B
  ctrl.ResSrc := 0.U
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := 0.U
  ctrl.rs2 := 0.U
  ctrl.rfWen := false.B
  ctrl.rd := 0.U

  // Data source preparation
  val data = Wire(new DataSrc)
  data.fuSrc1 := 0.U
  data.fuSrc2 := 0.U
  data.imm := imm
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare

  // Output connection
  io.to_isu.bits.cf <> io.from_ifu.bits
  io.to_isu.bits.ctrl <> ctrl
  io.to_isu.bits.data <> data
}

// ScoreBoard Module
class ScoreBoard(maxScore: Int) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val setMask = Input(UInt(NR_GPR.W))
    val clearMask = Input(UInt(NR_GPR.W))
    val isBusy = Output(UInt(NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  // Update logic
  for (i <- 0 until NR_GPR) {
    when(io.setMask(i) && !io.clearMask(i)) {
      busy(i) := busy(i) + 1.U
    }.elsewhen(!io.setMask(i) && io.clearMask(i)) {
      busy(i) := busy(i) - 1.U
    }
  }

  io.isBusy := busy.asUInt
}

// ISU Module
class ISU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(3))

  // Data hazard detection
  val rs1Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs2)
  val anyInvalidCondition = rs1Busy || rs2Busy

  // Handshake logic
  io.to_exu <> io.from_idu

  // Operand processing
  val fuSrc1 = MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> io.from_reg.rfSrc1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))

  val fuSrc2 = MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> io.from_reg.rfSrc2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Connect operands
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.setMask := isFireSetMask
  sb.io.clearMask := wbuClearMask
}

// dut Module
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))
    val pc = Output(UInt(XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })

  val ifu = Module(new IFU)
  val idu = Module(new IDU)
  val isu = Module(new ISU)

  // Connect IFU
  ifu.io.inst := io.inst
  ifu.io.redirect := io.ifuredirect
  io.pc := ifu.io.pc

  // Connect IDU
  idu.io.from_ifu <> ifu.io.to_idu

  // Connect ISU
  isu.io.from_idu <> idu.io.to_isu
  isu.io.wb := io.wb
  isu.io.from_reg.rfSrc1 := io.rfSrc1
  isu.io.from_reg.rfSrc2 := io.rfSrc2
  io.to_exu <> isu.io.to_exu

  // RS1 and RS2 outputs
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2
}

// Main object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
