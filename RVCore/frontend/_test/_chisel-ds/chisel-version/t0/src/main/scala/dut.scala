import chisel3._
import chisel3.util._

// Define common parameters and bundles
class NPCBundle extends Bundle {
  // Common bundle definitions for the processor
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

// Define module parameters and traits
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

object FuType extends HasNPCParameter {
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// Define submodules
class IFU extends Module {
  val io = IO(new NPCBundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit(0x80000000.U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // PC update logic
  when(io.redirect.valid) {
    pcReg := io.redirect.target
  }.otherwise {
    pcReg := nextPc
  }

  io.pc := pcReg
  nextPc := pcReg + 4.U

  // Control flow output
  io.to_idu.valid := true.B
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
}

class IDU extends Module {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Instruction decoding logic
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(io.from_ifu.bits.inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
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

  // Immediate extension logic
  val imm = Wire(UInt(XLen.W))
  imm := 0.U

  // Data source preparation
  val data = Wire(new DataSrc)
  data.fuSrc1 := 0.U
  data.fuSrc2 := 0.U
  data.imm := imm

  // Output connection
  io.to_isu.valid := io.from_ifu.valid
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

class ISU extends Module {
  val io = IO(new NPCBundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = new ScoreBoard(3)

  // Data hazard detection
  val rs1Busy = sb.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.isBusy(io.from_idu.bits.ctrl.rs2)
  val anyInvalidCondition = rs1Busy || rs2Busy

  // Handshake logic
  HandShakeDeal(io.from_idu, io.to_exu, anyInvalidCondition)

  // Operand processing
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Output connection
  io.to_exu.bits := io.from_idu.bits
  io.to_exu.bits.data.fuSrc1 := rs1
  io.to_exu.bits.data.fuSrc2 := rs2
}

class ScoreBoard(maxScore: Int) extends Module {
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

  // Output logic
  io.isBusy := busy.asUInt
}

// Main dut module
class dut extends Module {
  val io = IO(new NPCBundle {
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
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb
  io.rs1 := isu.io.from_reg.rfSrc1
  io.rs2 := isu.io.from_reg.rfSrc2

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}

// Helper functions
object StageConnect {
  def apply(from: DecoupledIO[CtrlFlow], to: DecoupledIO[CtrlFlow], fire: Bool, redirect: Bool): Unit = {
    to.valid := from.valid && !redirect
    from.ready := to.ready && !redirect
    to.bits := from.bits
  }
}

object HandShakeDeal {
  def apply(from: DecoupledIO[DecodeIO], to: DecoupledIO[DecodeIO], anyInvalidCondition: Bool): Unit = {
    to.valid := from.valid && !anyInvalidCondition
    from.ready := to.ready && !anyInvalidCondition
    to.bits := from.bits
  }
}
