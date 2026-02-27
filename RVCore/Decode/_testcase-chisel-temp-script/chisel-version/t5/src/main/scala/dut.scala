// package npc

import chisel3._
import chisel3.util._

// Base class for NPC modules
trait HasNPCParameter {
  val XLen = 64
  val IndependentBru = true
}

// Base bundle class for NPC
class NPCBundle extends Bundle with HasNPCParameter

// Base module class for NPC
abstract class NPCModule extends Module with HasNPCParameter

// Trait for instruction types
trait TYPE_INST {
  def TYPE_N = "b0000".U
  def TYPE_I = "b0100".U
  def TYPE_R = "b0101".U
  def TYPE_S = "b0010".U
  def TYPE_B = "b0001".U
  def TYPE_U = "b0110".U
  def TYPE_J = "b0111".U

  def isRegWrite(instType: UInt): Bool = instType(2) === 1.U
}

// Functional unit type definitions
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

// ALU operation type definitions
object ALUOpType {
  def sll = "b0000000".U
  def srl = "b0000001".U
  def sra = "b0000010".U
  def add = "b0000011".U
  def sub = "b0000100".U
  def and = "b0000101".U
  def or  = "b0000110".U
  def xor = "b0000111".U
  def slt = "b0001000".U
  def sltu= "b0001001".U
  def apply() = UInt(7.W)
}

// Functional unit operation type
object FuOpType {
  def apply() = UInt(7.W)
}

// Source operand type definitions
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// RISC-V instruction definitions
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// RISC-V base instruction set
object RVI_Inst extends TYPE_INST with HasNPCParameter {
  import ALUOpType._
  
  // Sample instruction table - in a real implementation this would include all RISC-V instructions
  def table = Array(
    // R-type instructions
    BitPat("b0000000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, add, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // ADD
    BitPat("b0100000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, sub, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SUB
    BitPat("b0000000_?????_?????_111_?????_0110011") -> List(TYPE_R, FuType.alu, and, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // AND
    BitPat("b0000000_?????_?????_110_?????_0110011") -> List(TYPE_R, FuType.alu, or,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // OR
    BitPat("b0000000_?????_?????_100_?????_0110011") -> List(TYPE_R, FuType.alu, xor, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // XOR
    
    // I-type instructions
    BitPat("b???????_?????_?????_000_?????_0010011") -> List(TYPE_I, FuType.alu, add, FuSrcType.rfSrc1, FuSrcType.imm),     // ADDI
    BitPat("b???????_?????_?????_000_?????_0000011") -> List(TYPE_I, FuType.lsu, add, FuSrcType.rfSrc1, FuSrcType.imm),     // LOAD
    
    // S-type instructions
    BitPat("b???????_?????_?????_???_?????_0100011") -> List(TYPE_S, FuType.lsu, add, FuSrcType.rfSrc1, FuSrcType.imm),     // STORE
    
    // B-type instructions
    BitPat("b???????_?????_?????_???_?????_1100011") -> List(TYPE_B, FuType.bru, add, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BRANCH
    
    // U-type instructions
    BitPat("b???????_?????_?????_???_?????_0110111") -> List(TYPE_U, FuType.alu, add, FuSrcType.zero, FuSrcType.imm),       // LUI
    BitPat("b???????_?????_?????_???_?????_0010111") -> List(TYPE_U, FuType.alu, add, FuSrcType.pc, FuSrcType.imm),         // AUIPC
    
    // J-type instructions
    BitPat("b???????_?????_?????_???_?????_1101111") -> List(TYPE_J, FuType.alu, add, FuSrcType.pc, FuSrcType.four)         // JAL
  )
}

// Control flow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Control signal bundle
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

// Data source bundle
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

// Main IDU module
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
  
  // Handle handshake between IFU and ISU
  val AnyInvalidCondition = false.B
  
  def HandShakeDeal(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalidCondition: Bool): Unit = {
    out.valid := in.valid && !invalidCondition
    in.ready := out.ready || invalidCondition
    
    // Pass data when valid
    when(in.valid && !invalidCondition) {
      out.bits.cf := in.bits
    }
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)
  
  // Extract instruction from IFU
  val inst = io.from_ifu.bits.inst
  
  // Decode instruction
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Extract register fields
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd = inst(11, 7)
  
  // Generate control signals
  val ctrl = Wire(new CtrlSignal)
  ctrl.rs1 := rs1
  ctrl.rs2 := rs2
  ctrl.rd := rd
  ctrl.rfWen := isRegWrite(instType)
  ctrl.MemWrite := instType === TYPE_S
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instructions
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR instructions
  ))
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  
  // Generate immediate values based on instruction type
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Array(
    (instType === TYPE_I) -> SignExt(inst(31, 20), XLen),
    (instType === TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen),
    (instType === TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    (instType === TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  ))
  
  // Prepare data sources
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm
  
  // Connect to output
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
