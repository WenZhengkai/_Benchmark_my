// package npc

import chisel3._
import chisel3.util._

// Define instruction types
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
  val XLen = 64
  val IndependentBru = true
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

// Define ALU operation types
object ALUOpType {
  def sll = "b0000000".U
  def add = "b0000001".U
  def sub = "b0000010".U
  // Add more ALU operations as needed
  def apply() = UInt(7.W)
}

// Instructions and decode table
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// RISC-V instruction set
object RVI_Inst extends TYPE_INST with HasNPCParameter {
  // This is a simplified table - in a real implementation you would have all RISC-V instructions
  val table = Array(
    BitPat("b?????????????????000?????0110011") -> List(TYPE_R, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.rfSrc2),   // ADD
    BitPat("b?????????????????000?????0010011") -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),     // ADDI
    // Add more instructions as needed
    BitPat("b00000000000000000000000000010011") -> List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)      // NOP
  )
}

// Base class for bundles
abstract class NPCBundle extends Bundle with HasNPCParameter

// Base class for modules
abstract class NPCModule extends Module with HasNPCParameter

// Control flow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Control signals bundle
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

// Main decoder module
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake handling
  val AnyInvalidCondition = false.B
  
  def HandShakeDeal(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready || invalid
    
    // Default output when invalid
    when(invalid) {
      out.bits.cf.inst := Instructions.NOP
      out.bits.cf.pc := 0.U
      out.bits.cf.next_pc := 0.U
      out.bits.cf.isBranch := false.B
    }
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)
  
  // Sign extension helper function
  def SignExt(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    if (aLen >= len) a(len-1, 0) else Cat(Fill(len - aLen, a(aLen-1)), a)
  }
  
  // Extract instruction fields
  val inst = io.from_ifu.bits.inst
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd = inst(11, 7)
  
  // Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  
  // Immediate value generation
  val immI = SignExt(inst(31, 20), XLen)
  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val immB = SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val immJ = SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  
  // Determine immediate value based on instruction type
  val imm = MuxLookup(instType, 0.U, Seq(
    TYPE_I -> immI,
    TYPE_S -> immS,
    TYPE_B -> immB,
    TYPE_U -> immU,
    TYPE_J -> immJ
  ))
  
  // Control signal generation
  val rfWen = isRegWrite(instType) && rd =/= 0.U
  val memWrite = instType === TYPE_S
  val resSrc = MuxLookup(inst(6, 0), 0.U, Seq(
    "b0000011".U -> 1.U,  // Load
    "b1110011".U -> 2.U   // CSR
  ))
  
  // Connect to output
  io.to_isu.bits.cf <> io.from_ifu.bits
  
  val ctrl = io.to_isu.bits.ctrl
  ctrl.MemWrite := memWrite
  ctrl.ResSrc := resSrc
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := rs1
  ctrl.rs2 := rs2
  ctrl.rfWen := rfWen
  ctrl.rd := rd
  
  val data = io.to_isu.bits.data
  data.imm := imm
  // Set other data fields to DontCare
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare
}
