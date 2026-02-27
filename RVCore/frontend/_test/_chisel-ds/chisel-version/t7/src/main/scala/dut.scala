import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define common bundles and parameters
class NPCBundle extends Bundle {
  val XLen = 32 // Default XLEN for RISC-V
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

// Define enums and constants
object FuSrcType extends ChiselEnum {
  val rfSrc1, rfSrc2, pc, imm, zero, four = Value
}

object FuType extends ChiselEnum {
  val alu, lsu, mdu, csr, mou, bru = Value
}

object FuOpType extends ChiselEnum {
  val add, sll, slt, sltu, xor, srl, or, and, sub, sra, beq, bne, blt, bge, bltu, bgeu, sb, sh, sw, lb, lh, lw, lbu, lhu, wrt, set, jmp = Value
}

// IFU Module
class IFU_LLM2 extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit(0x80000000.U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // Simple branch prediction
  val snpc = pcReg + 4.U
  val predictPc = snpc

  // Next PC calculation logic
  nextPc := MuxCase(pcReg, Seq(
    io.redirect.valid -> io.redirect.target,
    !io.to_idu.ready -> pcReg,
    true.B -> predictPc
  ))

  pcReg := nextPc
  io.pc := pcReg

  // Output logic
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
  io.to_idu.valid := true.B
}

// IDU Module
class IDU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Instruction decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := inst(6, 0) === "b0100011".U
  ctrl.ResSrc := MuxCase(0.U, Seq(
    inst(6, 0) === "b0000011".U -> 1.U,
    inst(6, 0) === "b1110011".U -> 2.U
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Seq(
    instType === TYPE_I -> SignExt(inst(31, 20), XLen),
    instType === TYPE_U -> Cat(inst(31, 12), 0.U(12.W)),
    instType === TYPE_J -> Cat(Fill(XLen - 21, inst(31)), inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)),
    instType === TYPE_S -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    instType === TYPE_B -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data.imm := imm
  data <> DontCare

  // Output connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// ISU Module
class ISU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Scoreboard instantiation
  val sb = new ScoreBoard(3)

  // Data hazard detection
  val inBits = io.from_idu.bits
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake processing
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Operand processing
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> io.from_reg.rfSrc1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> io.from_reg.rfSrc2,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Connect output
  io.to_exu.bits := inBits
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
}

// dut Module
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
  val isu = Module(new ISU_LLM2)

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb

  // Register source processing
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}

// Helper functions and objects
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

object RVI_Inst extends HasNPCParameter {
  val table = Array(
    // Define instruction decoding table here
  )
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))
  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U
  def mask(idx: UInt): UInt = (1.U << idx).asUInt
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      busy(i) := MuxCase(busy(i), Seq(
        (setMask(i) && clearMask(i)) -> busy(i),
        setMask(i) -> Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i)),
        clearMask(i) -> Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      ))
    }
  }
}

def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
  out.valid := in.valid && !anyInvalidCondition
  in.ready := out.ready && !anyInvalidCondition
  out.bits := in.bits
}

def StageConnect[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], fire: Bool, redirect: Bool): Unit = {
  out.valid := in.valid && !redirect
  in.ready := out.ready && !redirect
  out.bits := in.bits
  when(fire && redirect) {
    in.ready := false.B
    out.valid := false.B
  }
}
