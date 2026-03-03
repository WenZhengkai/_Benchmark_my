import chisel3._
import chisel3.util._

// Trait for instruction type definitions
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

// Base trait for NPC parameters
trait HasNPCParameter {
  val XLen: Int = 64
  val IndependentBru: Boolean = false
}

// Base Bundle class
class NPCBundle extends Bundle with HasNPCParameter

// Base Module class
class NPCModule extends Module with HasNPCParameter

// Control Flow Bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

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

// Functional Unit Operation Type
object FuOpType {
  def apply() = UInt(7.W)
}

// Functional Unit Source Type
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// ALU Operation Type placeholder
object ALUOpType {
  def sll = "b0000000".U
}

// RVI Instruction table placeholder
object RVI_Inst {
  def table: Array[(BitPat, List[UInt])] = Array()
}

// Instructions object
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// Control Signal Bundle
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

// Data Source Bundle
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

// Decode IO Bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Sign extension function
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    val signBit = a(aLen - 1)
    if (aLen >= len) a(len - 1, 0)
    else Cat(Fill(len - aLen, signBit), a)
  }
}

// Handshake Deal function
object HandShakeDeal {
  def apply(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalidCondition: Bool): Unit = {
    in.ready := out.ready || invalidCondition
    out.valid := in.valid && !invalidCondition
  }
}

// Main dut Module
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Get instruction from IFU
  val inst = io.from_ifu.bits.inst

  // Instruction decoding using ListLookup
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  
  // Register write enable
  ctrl.rfWen := Instructions.isRegWrite(instType)
  
  // Extract register fields
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  
  // Memory write enable (S-type instructions)
  ctrl.MemWrite := (instType === Instructions.TYPE_S)
  
  // Result source select
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instruction
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR operation
  ))
  
  // Source operand types and functional unit configuration
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxLookup(instType, 0.U, Seq(
    // I-type: 12-bit sign extension
    Instructions.TYPE_I -> SignExt(inst(31, 20), XLen),
    
    // U-type: 20-bit immediate shifted left 12 bits
    Instructions.TYPE_U -> SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen),
    
    // J-type: 20-bit sign extension (inst[20|10:1|11|19:12])
    Instructions.TYPE_J -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen),
    
    // S-type: 12-bit sign extension
    Instructions.TYPE_S -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    
    // B-type: 12-bit sign extension (inst[12|10:5|4:1|11])
    Instructions.TYPE_B -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data <> DontCare
  data.imm := imm

  // Output connections
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
