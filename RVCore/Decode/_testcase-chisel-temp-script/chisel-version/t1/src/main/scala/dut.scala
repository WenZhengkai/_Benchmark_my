// package npc

import chisel3._
import chisel3.util._
import npc.alu.ALUOpType

// Define trait for instruction types
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

// Trait for NPC parameters
trait HasNPCParameter {
  val XLen = 32
  val IndependentBru = true
}

// NPC Bundle base class
abstract class NPCBundle extends Bundle with HasNPCParameter

// NPC Module base class
abstract class NPCModule extends Module with HasNPCParameter

// Functional Unit Type definitions
object FuType extends HasNPCParameter {
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if(IndependentBru) "b101".U else alu
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

// Instructions definition
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// Control Flow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Control Signal bundle
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

// Data Source bundle
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

// Decode IO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Main dut module - Instruction Decoder
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Helper function for sign extension
  def SignExt(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    if (aLen >= len) a(aLen-1, 0)
    else Cat(Fill(len - aLen, a(aLen-1)), a)
  }

  // Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Extract instruction from input
  val inst = io.from_ifu.bits.inst

  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Generate control signals
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instruction
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR operation
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Immediate extension based on instruction type
  val data = Wire(new DataSrc)
  data := DontCare
  
  data.imm := MuxCase(0.U, Seq(
    // I-type immediate
    (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),
    
    // U-type immediate
    (instType === Instructions.TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    
    // J-type immediate
    (instType === Instructions.TYPE_J) -> SignExt(
      Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen),
    
    // S-type immediate
    (instType === Instructions.TYPE_S) -> SignExt(
      Cat(inst(31, 25), inst(11, 7)), XLen),
    
    // B-type immediate
    (instType === Instructions.TYPE_B) -> SignExt(
      Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  ))

  // Connect output
  io.to_isu.bits.cf <> io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// HandShakeDeal helper method for ready/valid handshake
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], invalidCondition: Bool): Unit = {
    out.valid := in.valid && !invalidCondition
    in.ready := out.ready && !invalidCondition
    out.bits := in.bits
  }
}

// ALUOpType object (presumed to be defined elsewhere, included for completeness)
// package object alu {
  object ALUOpType {
    def sll  = "b0000001".U
    def srl  = "b0000010".U
    def sra  = "b0000011".U
    def add  = "b0000100".U
    def sub  = "b0000101".U
    def and  = "b0000110".U
    def or   = "b0000111".U
    def xor  = "b0001000".U
    def slt  = "b0001001".U
    def sltu = "b0001010".U
    def addw = "b0001011".U
    def subw = "b0001100".U
    def sllw = "b0001101".U
    def srlw = "b0001110".U
    def sraw = "b0001111".U
    // Add other ALU operations as needed
  }
}

// RVI_Inst object (assumed to be defined elsewhere)
object RVI_Inst extends HasNPCParameter with TYPE_INST {
  import alu.ALUOpType
  
  // This is a simplified version - in a real implementation this would contain
  // the full RISC-V instruction decoding table
  val table = Array(
    // Format: Instruction pattern -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
    
    // R-type instructions
    BitPat("b0000000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BitPat("b0100000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sub,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BitPat("b0000000_?????_?????_001_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sll,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BitPat("b0000000_?????_?????_010_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    
    // I-type instructions
    BitPat("b???????_?????_?????_000_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),
    BitPat("b???????_?????_?????_010_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.imm),
    BitPat("b???????_?????_?????_000_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),
    
    // S-type instructions
    BitPat("b???????_?????_?????_010_?????_0100011") -> List(TYPE_S, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),
    
    // B-type instructions
    BitPat("b???????_?????_?????_000_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.add,  FuSrcType.pc, FuSrcType.imm),
    
    // U-type instructions
    BitPat("b???????_?????_?????_???_?????_0110111") -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.zero, FuSrcType.imm),
    BitPat("b???????_?????_?????_???_?????_0010111") -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.pc, FuSrcType.imm),
    
    // J-type instructions
    BitPat("b???????_?????_?????_???_?????_1101111") -> List(TYPE_J, FuType.alu, ALUOpType.add,  FuSrcType.pc, FuSrcType.four)
  )
}
