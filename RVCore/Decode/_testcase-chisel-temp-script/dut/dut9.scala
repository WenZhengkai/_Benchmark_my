// package processor

import chisel3._
import chisel3.util._

// Base trait for NPC modules
trait HasNPCParameter {
  val XLen: Int = 32
  val IndependentBru: Boolean = false
}

// Base class for NPC modules
abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

// Trait defining instruction types
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

// ALU operation types
object ALUOpType {
  def sll = "b0000001".U
  def add = "b0000010".U
  def sub = "b0000011".U
  def slt = "b0000100".U
  def xor = "b0000101".U
  def or  = "b0000110".U
  def and = "b0000111".U
  def srl = "b0001000".U
  def sra = "b0001001".U
  def lui = "b0001010".U
  def sltu = "b0001011".U
  // Other ALU operations can be defined here
}

// Functional unit operation type
object FuOpType {
  def apply() = UInt(7.W)
}

// Source operand type for functional units
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
  
  // RV32I instruction decode table
  object RVI_Inst {
    import ALUOpType._
    
    val table = Array(
      // R-type instructions
      BitPat("b0000000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // ADD
      BitPat("b0100000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, sub,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SUB
      BitPat("b0000000_?????_?????_001_?????_0110011") -> List(TYPE_R, FuType.alu, sll,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SLL
      BitPat("b0000000_?????_?????_010_?????_0110011") -> List(TYPE_R, FuType.alu, slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SLT
      BitPat("b0000000_?????_?????_011_?????_0110011") -> List(TYPE_R, FuType.alu, sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SLTU
      BitPat("b0000000_?????_?????_100_?????_0110011") -> List(TYPE_R, FuType.alu, xor,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // XOR
      BitPat("b0000000_?????_?????_101_?????_0110011") -> List(TYPE_R, FuType.alu, srl,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SRL
      BitPat("b0100000_?????_?????_101_?????_0110011") -> List(TYPE_R, FuType.alu, sra,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // SRA
      BitPat("b0000000_?????_?????_110_?????_0110011") -> List(TYPE_R, FuType.alu, or,   FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // OR
      BitPat("b0000000_?????_?????_111_?????_0110011") -> List(TYPE_R, FuType.alu, and,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // AND

      // I-type instructions
      BitPat("b???????_?????_?????_000_?????_0010011") -> List(TYPE_I, FuType.alu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // ADDI
      BitPat("b???????_?????_?????_010_?????_0010011") -> List(TYPE_I, FuType.alu, slt,  FuSrcType.rfSrc1, FuSrcType.imm),     // SLTI
      BitPat("b???????_?????_?????_011_?????_0010011") -> List(TYPE_I, FuType.alu, sltu, FuSrcType.rfSrc1, FuSrcType.imm),     // SLTIU
      BitPat("b???????_?????_?????_100_?????_0010011") -> List(TYPE_I, FuType.alu, xor,  FuSrcType.rfSrc1, FuSrcType.imm),     // XORI
      BitPat("b???????_?????_?????_110_?????_0010011") -> List(TYPE_I, FuType.alu, or,   FuSrcType.rfSrc1, FuSrcType.imm),     // ORI
      BitPat("b???????_?????_?????_111_?????_0010011") -> List(TYPE_I, FuType.alu, and,  FuSrcType.rfSrc1, FuSrcType.imm),     // ANDI
      BitPat("b0000000_?????_?????_001_?????_0010011") -> List(TYPE_I, FuType.alu, sll,  FuSrcType.rfSrc1, FuSrcType.imm),     // SLLI
      BitPat("b0000000_?????_?????_101_?????_0010011") -> List(TYPE_I, FuType.alu, srl,  FuSrcType.rfSrc1, FuSrcType.imm),     // SRLI
      BitPat("b0100000_?????_?????_101_?????_0010011") -> List(TYPE_I, FuType.alu, sra,  FuSrcType.rfSrc1, FuSrcType.imm),     // SRAI

      // Load instructions
      BitPat("b???????_?????_?????_000_?????_0000011") -> List(TYPE_I, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // LB
      BitPat("b???????_?????_?????_001_?????_0000011") -> List(TYPE_I, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // LH
      BitPat("b???????_?????_?????_010_?????_0000011") -> List(TYPE_I, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // LW
      BitPat("b???????_?????_?????_100_?????_0000011") -> List(TYPE_I, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // LBU
      BitPat("b???????_?????_?????_101_?????_0000011") -> List(TYPE_I, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // LHU

      // Store instructions
      BitPat("b???????_?????_?????_000_?????_0100011") -> List(TYPE_S, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // SB
      BitPat("b???????_?????_?????_001_?????_0100011") -> List(TYPE_S, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // SH
      BitPat("b???????_?????_?????_010_?????_0100011") -> List(TYPE_S, FuType.lsu, add,  FuSrcType.rfSrc1, FuSrcType.imm),     // SW

      // Branch instructions
      BitPat("b???????_?????_?????_000_?????_1100011") -> List(TYPE_B, FuType.bru, add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BEQ
      BitPat("b???????_?????_?????_001_?????_1100011") -> List(TYPE_B, FuType.bru, add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BNE
      BitPat("b???????_?????_?????_100_?????_1100011") -> List(TYPE_B, FuType.bru, slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BLT
      BitPat("b???????_?????_?????_101_?????_1100011") -> List(TYPE_B, FuType.bru, slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BGE
      BitPat("b???????_?????_?????_110_?????_1100011") -> List(TYPE_B, FuType.bru, sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BLTU
      BitPat("b???????_?????_?????_111_?????_1100011") -> List(TYPE_B, FuType.bru, sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),  // BGEU

      // Jump instructions
      BitPat("b???????_?????_?????_???_?????_1101111") -> List(TYPE_J, FuType.alu, add,  FuSrcType.pc,    FuSrcType.four),    // JAL
      BitPat("b???????_?????_?????_000_?????_1100111") -> List(TYPE_I, FuType.alu, add,  FuSrcType.pc,    FuSrcType.four),    // JALR

      // U-type instructions
      BitPat("b???????_?????_?????_???_?????_0110111") -> List(TYPE_U, FuType.alu, lui,  FuSrcType.imm,   FuSrcType.zero),    // LUI
      BitPat("b???????_?????_?????_???_?????_0010111") -> List(TYPE_U, FuType.alu, add,  FuSrcType.pc,    FuSrcType.imm),     // AUIPC

      // Other instructions can be added as needed
    )
  }
  
  def DecodeTable = RVI_Inst.table
}

// Control flow information bundle
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

// Decode output bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Instruction Decode Unit
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
  
  def HandShakeDeal(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], cond: Bool): Unit = {
    out.valid := in.valid && !cond
    in.ready := out.ready || cond
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)
  
  // Get the instruction from IFU
  val inst = io.from_ifu.bits.inst
  
  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Create decode output signals
  val cf = Wire(new CtrlFlow)
  val ctrl = Wire(new CtrlSignal)
  val data = Wire(new DataSrc)
  
  // Pass through control flow information
  cf := io.from_ifu.bits
  
  // Extract register fields
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd = inst(11, 7)
  
  // Control signal generation
  ctrl.rs1 := rs1
  ctrl.rs2 := rs2
  ctrl.rd := rd
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instruction
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR operation
  ))
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  
  // Immediate value generation based on instruction type
  val immI = SignExt(inst(31, 20), XLen)
  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val immB = SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val immJ = SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  
  // Select the immediate based on instruction type
  data.imm := MuxCase(0.U, Array(
    (instType === Instructions.TYPE_I) -> immI,
    (instType === Instructions.TYPE_S) -> immS,
    (instType === Instructions.TYPE_B) -> immB,
    (instType === Instructions.TYPE_U) -> immU,
    (instType === Instructions.TYPE_J) -> immJ
  ))
  
  // Initialize other data signals
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare
  
  // Connect to output
  io.to_isu.bits.cf := cf
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
