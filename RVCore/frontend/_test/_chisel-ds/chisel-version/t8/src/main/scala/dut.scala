import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define common parameters and bundles
trait HasNPCParameter {
  val XLen = 32
  val NR_GPR = 32
}

class NPCBundle extends Bundle with HasNPCParameter

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
  val ResSrc = UInt(2.W)
  val fuSrc1Type = UInt(3.W)
  val fuSrc2Type = UInt(3.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(7.W)
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

// IFU Module
class IFU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit("h80000000".U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // Simple branch prediction logic
  val snpc = pcReg + 4.U
  val predictPc = snpc

  // next_pc calculation logic
  nextPc := MuxCase(pcReg, Seq(
    io.redirect.valid -> io.redirect.target,
    !io.to_idu.ready -> pcReg,
    true.B -> predictPc
  ))

  pcReg := nextPc
  io.pc := pcReg

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

  val inst = io.from_ifu.bits.inst
  val pc = io.from_ifu.bits.pc

  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.MemWrite := inst(6, 0) === "b0100011".U
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,
    (inst(6, 0) === "b1110011".U) -> 2.U
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.rfWen := instType(2)

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Seq(
    (instType === Instructions.TYPE_I) -> Cat(Fill(20, inst(31)), inst(31, 20)),
    (instType === Instructions.TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    (instType === Instructions.TYPE_J) -> Cat(Fill(12, inst(31)), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)),
    (instType === Instructions.TYPE_S) -> Cat(Fill(20, inst(31)), inst(31, 25), inst(11, 7)),
    (instType === Instructions.TYPE_B) -> Cat(Fill(20, inst(31)), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data.imm := imm
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare

  // Output connection
  io.to_isu.valid := io.from_ifu.valid
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
  io.from_ifu.ready := io.to_isu.ready
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
      busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
    }.elsewhen(!io.setMask(i) && io.clearMask(i)) {
      busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
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
  val hazardDetected = rs1Busy.orR || rs2Busy.orR

  // Handshake logic
  io.from_idu.ready := io.to_exu.ready && !hazardDetected
  io.to_exu.valid := io.from_idu.valid && !hazardDetected
  io.to_exu.bits := io.from_idu.bits

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxCase(0.U, Seq(
    (io.from_idu.bits.ctrl.fuSrc1Type === 0.U) -> io.from_reg.rfSrc1,
    (io.from_idu.bits.ctrl.fuSrc1Type === 2.U) -> io.from_idu.bits.cf.pc,
    (io.from_idu.bits.ctrl.fuSrc1Type === 4.U) -> 0.U
  ))
  io.to_exu.bits.data.fuSrc2 := MuxCase(0.U, Seq(
    (io.from_idu.bits.ctrl.fuSrc2Type === 1.U) -> io.from_reg.rfSrc2,
    (io.from_idu.bits.ctrl.fuSrc2Type === 3.U) -> io.from_idu.bits.data.imm,
    (io.from_idu.bits.ctrl.fuSrc2Type === 5.U) -> 4.U
  ))

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

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect

  idu.io.from_ifu <> ifu.io.to_idu
  isu.io.from_idu <> idu.io.to_isu
  io.to_exu <> isu.io.to_exu

  isu.io.wb := io.wb
  isu.io.from_reg.rfSrc1 := io.rfSrc1
  isu.io.from_reg.rfSrc2 := io.rfSrc2

  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2
}

// Helper objects and functions
object Instructions extends HasNPCParameter {
  def TYPE_N = "b0000".U
  def TYPE_I = "b0100".U
  def TYPE_R = "b0101".U
  def TYPE_S = "b0010".U
  def TYPE_B = "b0001".U
  def TYPE_U = "b0110".U
  def TYPE_J = "b0111".U

  def isRegWrite(instType: UInt): Bool = instType(2, 2) === 1.U

  def DecodeDefault = List(TYPE_N, 0.U, 0.U, 0.U, 0.U)
  def DecodeTable = Array(
    // Add your instruction decoding logic here
  )
}

object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], fire: Bool, flush: Bool): Unit = {
    right.valid := left.valid && !flush
    left.ready := right.ready && !flush
    right.bits := left.bits
  }
}
