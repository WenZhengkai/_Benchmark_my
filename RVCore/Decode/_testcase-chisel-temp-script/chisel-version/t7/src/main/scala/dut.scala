// package npc

import chisel3._
import chisel3.util._

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

trait HasNPCParameter {
  val XLen = 32
  val IndependentBru = true
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

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

object ALUOpType {
  def sll = "b0000000".U
  def add = "b0000001".U
  def sub = "b0000010".U
  // More ALU operations would be defined here
  def apply() = UInt(7.W)
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
  
  // For simplicity, we're defining a minimal instruction set
  // In a real implementation, this would be much more extensive
  val RVI_Inst = Map(
    "b0110111".U -> List(TYPE_U, FuType.alu, ALUOpType.add, FuSrcType.zero, FuSrcType.imm), // LUI
    "b0010111".U -> List(TYPE_U, FuType.alu, ALUOpType.add, FuSrcType.pc, FuSrcType.imm),   // AUIPC
    "b1101111".U -> List(TYPE_J, FuType.bru, ALUOpType.add, FuSrcType.pc, FuSrcType.four),  // JAL
    "b1100111".U -> List(TYPE_I, FuType.bru, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm), // JALR
    "b1100011".U -> List(TYPE_B, FuType.bru, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.rfSrc2), // Branch
    "b0000011".U -> List(TYPE_I, FuType.lsu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm), // Load
    "b0100011".U -> List(TYPE_S, FuType.lsu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm), // Store
    "b0010011".U -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm), // ALU Imm
    "b0110011".U -> List(TYPE_R, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.rfSrc2) // ALU Reg
  )
  
  def DecodeTable = Array(
    (BitPat("b?????????????????000?????0110111"), RVI_Inst("b0110111".U)),
    (BitPat("b?????????????????000?????0010111"), RVI_Inst("b0010111".U)),
    (BitPat("b?????????????????000?????1101111"), RVI_Inst("b1101111".U)),
    (BitPat("b?????????????????000?????1100111"), RVI_Inst("b1100111".U)),
    (BitPat("b?????????????????000?????1100011"), RVI_Inst("b1100011".U)),
    (BitPat("b?????????????????000?????0000011"), RVI_Inst("b0000011".U)),
    (BitPat("b?????????????????000?????0100011"), RVI_Inst("b0100011".U)),
    (BitPat("b?????????????????000?????0010011"), RVI_Inst("b0010011".U)),
    (BitPat("b?????????????????000?????0110011"), RVI_Inst("b0110011".U))
  )
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

class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Helper function for sign extension
  def SignExt(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    if (aLen >= len) a(len-1, 0) else Cat(Fill(len - aLen, a(aLen-1)), a)
  }

  // Handshake processing
  val AnyInvalidCondition = false.B
  
  def HandShakeDeal(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    out.valid := in.valid && !invalidCond
    in.ready := out.ready || invalidCond
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)
  
  // Default values
  val inst = io.from_ifu.bits.inst
  val decode_io = Wire(new DecodeIO)
  decode_io.cf := io.from_ifu.bits
  decode_io.data := DontCare
  
  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.rfWen := isRegWrite(instType) && (ctrl.rd =/= 0.U)
  
  ctrl.MemWrite := instType === TYPE_S
  
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR
  ))
  
  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  
  imm := MuxCase(0.U, Array(
    (instType === TYPE_I) -> SignExt(inst(31, 20), XLen),
    (instType === TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen),
    (instType === TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    (instType === TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  ))
  
  // Data source preparation
  decode_io.ctrl := ctrl
  decode_io.data.imm := imm
  
  // Connect to output
  io.to_isu.bits := decode_io
}
