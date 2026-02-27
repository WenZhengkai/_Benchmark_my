// package npc

import chisel3._
import chisel3.util._
import npc.NPCConfig._

// Define instruction type traits
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

// Define functional unit types
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

// Define operation types for functional units
object FuOpType {
  def apply() = UInt(7.W)
}

// Define source operand types
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// ALU operation types (assuming this is defined elsewhere but needed for the decoder)
object ALUOpType {
  def sll = "b0000001".U
  // Other ALU operations would be defined here
  def apply() = UInt(7.W)
}

// Instructions object for decoding
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  
  // This would be defined in RVI_Inst, but we'll stub it here
  def DecodeTable = Array(
    // Actual decode table would be implemented here
    // Format: instruction pattern -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
  )
}

// Control Flow Bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
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

// The Decode Unit Module
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
  
  // Default values
  val decode_io = Wire(new DecodeIO)
  decode_io := DontCare
  
  // Extract instruction fields
  val inst = io.from_ifu.bits.inst
  val rs1_addr = inst(19, 15)
  val rs2_addr = inst(24, 20)
  val rd_addr = inst(11, 7)
  
  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Control signal generation
  val ctrl = decode_io.ctrl
  ctrl.rs1 := rs1_addr
  ctrl.rs2 := rs2_addr
  ctrl.rd := rd_addr
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
  
  // Immediate extension based on instruction type
  val imm = MuxCase(0.U(XLen.W), Array(
    (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),
    (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen),
    (instType === Instructions.TYPE_U) -> SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen),
    (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  ))
  
  // Data source preparation
  val data = decode_io.data
  data.imm := imm
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare
  
  // Control flow pass-through
  decode_io.cf := io.from_ifu.bits
  
  // Connect the decode_io to the output
  io.to_isu.bits := decode_io
}

// This would be defined elsewhere but needed for the implementation
trait HasNPCParameter {
  val XLen = 32
  val IndependentBru = true
}

// This would be defined elsewhere but needed for the implementation
class NPCBundle extends Bundle with HasNPCParameter

// This would be defined elsewhere but needed for the implementation
class NPCModule extends Module with HasNPCParameter {
  // Helper function for handshake handling
  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], invalidCondition: Bool): Unit = {
    out.valid := in.valid && !invalidCondition
    in.ready := out.ready && !invalidCondition
    out.bits := in.bits
  }
}

// Config object would be defined elsewhere
object NPCConfig {
  // Configuration settings
}
