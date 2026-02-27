// package npc

import chisel3._
import chisel3.util._

// Base NPC Bundle trait for all bundles in the design
trait NPCBundle extends Bundle with HasNPCParameter

// Base NPC Module trait for all modules in the design
trait NPCModule extends Module with HasNPCParameter

// Parameter trait for the NPC design
trait HasNPCParameter {
  val XLen = 64  // Data width (usually 32 or 64)
  val IndependentBru = true  // Whether to use an independent branch unit
}

// Instruction type definitions
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
  def bru = if(IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

// Functional unit operation type
object FuOpType {
  def apply() = UInt(7.W)
}

// ALU operation types
object ALUOpType {
  def sll  = "b0000000".U
  def srl  = "b0000001".U
  def sra  = "b0000010".U
  def add  = "b0000011".U
  def sub  = "b0000100".U
  def and  = "b0000101".U
  def or   = "b0000110".U
  def xor  = "b0000111".U
  def slt  = "b0001000".U
  def sltu = "b0001001".U
  def apply() = UInt(7.W)
}

// Functional unit source type
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply() = UInt(3.W)
}

// Instruction definitions
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  
  // RISC-V instruction decoding table
  def DecodeTable = Array(
    // R-type instructions
    BitPat("b0000000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // ADD
    BitPat("b0100000_?????_?????_000_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sub,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SUB
    BitPat("b0000000_?????_?????_001_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sll,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SLL
    BitPat("b0000000_?????_?????_010_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SLT
    BitPat("b0000000_?????_?????_011_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SLTU
    BitPat("b0000000_?????_?????_100_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.xor,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // XOR
    BitPat("b0000000_?????_?????_101_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.srl,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SRL
    BitPat("b0100000_?????_?????_101_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.sra,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // SRA
    BitPat("b0000000_?????_?????_110_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.or,   FuSrcType.rfSrc1, FuSrcType.rfSrc2), // OR
    BitPat("b0000000_?????_?????_111_?????_0110011") -> List(TYPE_R, FuType.alu, ALUOpType.and,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // AND
    
    // I-type instructions
    BitPat("b???????_?????_?????_000_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // ADDI
    BitPat("b???????_?????_?????_010_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.imm),    // SLTI
    BitPat("b???????_?????_?????_011_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.imm),    // SLTUI
    BitPat("b???????_?????_?????_100_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.xor,  FuSrcType.rfSrc1, FuSrcType.imm),    // XORI
    BitPat("b???????_?????_?????_110_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.or,   FuSrcType.rfSrc1, FuSrcType.imm),    // ORI
    BitPat("b???????_?????_?????_111_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.and,  FuSrcType.rfSrc1, FuSrcType.imm),    // ANDI
    BitPat("b0000000_?????_?????_001_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.sll,  FuSrcType.rfSrc1, FuSrcType.imm),    // SLLI
    BitPat("b0000000_?????_?????_101_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.srl,  FuSrcType.rfSrc1, FuSrcType.imm),    // SRLI
    BitPat("b0100000_?????_?????_101_?????_0010011") -> List(TYPE_I, FuType.alu, ALUOpType.sra,  FuSrcType.rfSrc1, FuSrcType.imm),    // SRAI
    
    // Load instructions
    BitPat("b???????_?????_?????_000_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // LB
    BitPat("b???????_?????_?????_001_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // LH
    BitPat("b???????_?????_?????_010_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // LW
    BitPat("b???????_?????_?????_100_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // LBU
    BitPat("b???????_?????_?????_101_?????_0000011") -> List(TYPE_I, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // LHU
    
    // Store instructions
    BitPat("b???????_?????_?????_000_?????_0100011") -> List(TYPE_S, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // SB
    BitPat("b???????_?????_?????_001_?????_0100011") -> List(TYPE_S, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // SH
    BitPat("b???????_?????_?????_010_?????_0100011") -> List(TYPE_S, FuType.lsu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),    // SW
    
    // Branch instructions
    BitPat("b???????_?????_?????_000_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BEQ
    BitPat("b???????_?????_?????_001_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BNE
    BitPat("b???????_?????_?????_100_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BLT
    BitPat("b???????_?????_?????_101_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BGE
    BitPat("b???????_?????_?????_110_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BLTU
    BitPat("b???????_?????_?????_111_?????_1100011") -> List(TYPE_B, FuType.bru, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2), // BGEU
    
    // U-type instructions
    BitPat("b???????_?????_?????_???_?????_0110111") -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.zero, FuSrcType.imm),      // LUI
    BitPat("b???????_?????_?????_???_?????_0010111") -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.pc,   FuSrcType.imm),      // AUIPC
    
    // J-type instructions
    BitPat("b???????_?????_?????_???_?????_1101111") -> List(TYPE_J, FuType.bru, ALUOpType.add,  FuSrcType.pc,   FuSrcType.four),     // JAL
    BitPat("b???????_?????_?????_000_?????_1100111") -> List(TYPE_I, FuType.bru, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm)     // JALR
  )
}

// Control Flow signal bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)      // Current instruction
  val pc = UInt(XLen.W)      // Instruction address
  val next_pc = UInt(XLen.W) // Next instruction address
  val isBranch = Bool()      // Is it a branch instruction?
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
  val fuSrc1 = UInt(XLen.W)               // Functional unit operand 1
  val fuSrc2 = UInt(XLen.W)               // Functional unit operand 2
  val imm = UInt(XLen.W)                  // Immediate value
  
  val Alu0Res = Decoupled(UInt(XLen.W))   // ALU calculation result
  val data_from_mem = UInt(XLen.W)        // Data read from memory
  val csrRdata = UInt(XLen.W)             // Data read from CSR
  val rfSrc1 = UInt(XLen.W)               // Data read from register 1
  val rfSrc2 = UInt(XLen.W)               // Data read from register 2
}

// Decode IO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow        // Control flow information
  val ctrl = new CtrlSignal    // Control signals
  val data = new DataSrc       // Data sources
}

// The main IDU module
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))  // Input from IFU
    val to_isu = Decoupled(new DecodeIO)             // Output to ISU
  })
  
  // Helper function for sign extension
  def SignExt(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    if (aLen >= len) a(aLen-1, 0)
    else Cat(Fill(len - aLen, a(aLen-1)), a)
  }
  
  // Handshake processing
  val AnyInvalidCondition = false.B
  
  def HandShakeDeal(in: DecoupledIO[_], out: DecoupledIO[_], condition: Bool): Unit = {
    out.valid := in.valid && !condition
    in.ready := out.ready && !condition
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)
  
  // Extract instruction from IFU
  val inst = io.from_ifu.bits.inst
  
  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Extract register fields
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd = inst(11, 7)
  
  // Generate control signals
  val ctrl = Wire(new CtrlSignal)
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.rs1 := rs1
  ctrl.rs2 := rs2
  ctrl.rd := rd
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  
  // Determine result source
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instruction
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR operation
  ))
  
  // Immediate expansion
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Array(
    (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),
    (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen),
    (instType === Instructions.TYPE_U) -> SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen),
    (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  ))
  
  // Prepare data sources
  val data = Wire(new DataSrc)
  data.imm := imm
  // Set other data sources as DontCare
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare
  
  // Connect outputs
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// Definition of RVI_Inst object used in Instructions
object RVI_Inst {
  val table = Instructions.DecodeTable
}
