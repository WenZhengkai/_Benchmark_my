import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define the necessary bundles and parameters
class Redirect extends Bundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class WbuToRegIO extends Bundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow extends Bundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = UInt(3.W)
  val fuSrc2Type = UInt(3.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(7.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends Bundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends Bundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class IFUIO extends Bundle {
  val inst = Input(UInt(32.W))
  val redirect = Input(new Redirect)
  val to_idu = Decoupled(new CtrlFlow)
  val pc = Output(UInt(XLen.W))
}

class IDUIO extends Bundle {
  val from_ifu = Flipped(Decoupled(new CtrlFlow))
  val to_isu = Decoupled(new DecodeIO)
}

class ISUIO extends Bundle {
  val from_idu = Flipped(Decoupled(new DecodeIO))
  val to_exu = Decoupled(new DecodeIO)
  val wb = Input(new WbuToRegIO)
  val from_reg = new Bundle {
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))
  }
}

// Define the IFU module
class IFU_LLM2 extends Module {
  val io = IO(new IFUIO)

  // Internal logic for IFU
  val pcReg = RegInit(0x80000000.U(XLen.W))
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

  // Output logic
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
  io.to_idu.valid := true.B
  io.pc := pcReg
}

// Define the IDU module
class IDU_LLM2 extends Module {
  val io = IO(new IDUIO)

  // Internal logic for IDU
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(io.from_ifu.bits.inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  val ctrl = Wire(new CtrlSignal)
  ctrl.MemWrite := false.B
  ctrl.ResSrc := 0.U
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := io.from_ifu.bits.inst(19, 15)
  ctrl.rs2 := io.from_ifu.bits.inst(24, 20)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rd := io.from_ifu.bits.inst(11, 7)

  val data = Wire(new DataSrc)
  data.imm := MuxCase(0.U, Seq(
    (instType === Instructions.TYPE_I) -> SignExt(Cat(io.from_ifu.bits.inst(31, 20)), XLen),
    (instType === Instructions.TYPE_U) -> Cat(io.from_ifu.bits.inst(31, 12), 0.U(12.W)),
    (instType === Instructions.TYPE_J) -> SignExt(Cat(io.from_ifu.bits.inst(31), io.from_ifu.bits.inst(19, 12), io.from_ifu.bits.inst(20), io.from_ifu.bits.inst(30, 21), 0.U(1.W)), XLen),
    (instType === Instructions.TYPE_S) -> SignExt(Cat(io.from_ifu.bits.inst(31, 25), io.from_ifu.bits.inst(11, 7)), XLen),
    (instType === Instructions.TYPE_B) -> SignExt(Cat(io.from_ifu.bits.inst(31), io.from_ifu.bits.inst(7), io.from_ifu.bits.inst(30, 25), io.from_ifu.bits.inst(11, 8), 0.U(1.W)), XLen)
  ))

  // Output connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
  io.to_isu.valid := io.from_ifu.valid
  io.from_ifu.ready := io.to_isu.ready
}

// Define the ISU module
class ISU_LLM2(maxScore: Int) extends Module {
  val io = IO(new ISUIO)

  // Instantiate ScoreBoard
  val sb = new ScoreBoard(maxScore)

  // Data hazard detection
  val rs1Busy = sb.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.isBusy(io.from_idu.bits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake processing
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxCase(0.U, Seq(
    (io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) -> io.from_reg.rfSrc1,
    (io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.pc) -> io.from_idu.bits.cf.pc,
    (io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.zero) -> 0.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxCase(0.U, Seq(
    (io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) -> io.from_reg.rfSrc2,
    (io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.imm) -> io.from_idu.bits.data.imm,
    (io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.four) -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Connect Output
  io.to_exu.bits.cf := io.from_idu.bits.cf
  io.to_exu.bits.ctrl := io.from_idu.bits.ctrl
  io.to_exu.bits.data.imm := io.from_idu.bits.data.imm
}

// Define the dut module
class dut extends Module {
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

  // Instantiate submodules
  val ifu = Module(new IFU_LLM2)
  val idu = Module(new IDU_LLM2)
  val isu = Module(new ISU_LLM2(3))

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)

  // Register source processing
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2
}

// Helper functions and objects
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

class ScoreBoard(maxScore: Int) {
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U
  def mask(idx: UInt): UInt = (1.U << idx).asUInt
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      busy(i) := MuxCase(busy(i), Seq(
        (setMask(i) && clearMask(i)) -> busy(i),
        setMask(i) -> (busy(i) + 1.U),
        clearMask(i) -> (busy(i) - 1.U)
      ))
    }
  }
}

def StageConnect[T <: Data](from: DecoupledIO[T], to: DecoupledIO[T], fire: Bool, flush: Bool): Unit = {
  to.bits := from.bits
  to.valid := from.valid
  from.ready := to.ready
  when(flush) {
    to.valid := false.B
    from.ready := true.B
  }
}

def HandShakeDeal[T <: Data](from: DecoupledIO[T], to: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
  to.bits := from.bits
  to.valid := from.valid && !anyInvalidCondition
  from.ready := to.ready && !anyInvalidCondition
}

// Define the main object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
