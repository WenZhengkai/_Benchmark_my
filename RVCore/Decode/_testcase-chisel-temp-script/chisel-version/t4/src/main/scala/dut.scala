// package npc

import chisel3._
import chisel3.util._
import freechips.rocketchip.config.Parameters

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

abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

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

object ALUOpType {
  def sll = "b0000000".U
  // Other ALU operations would be defined here
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
  
  // This would be replaced with actual RISC-V instruction definitions
  object RVI_Inst {
    val table = Array(
      // Format: Instruction pattern -> (instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
      BitPat("b0000000??????????000?????0110011") -> List(TYPE_R, FuType.alu, "b0000000".U, FuSrcType.rfSrc1, FuSrcType.rfSrc2), // ADD
      BitPat("b?????????????????000?????0010011") -> List(TYPE_I, FuType.alu, "b0000001".U, FuSrcType.rfSrc1, FuSrcType.imm),    // ADDI
      // Add more instructions as needed
    )
  }
  
  def DecodeTable = RVI_Inst.table
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

  // Handshake handling
  val AnyInvalidCondition = false.B
  
  def HandShakeDeal(from: DecoupledIO[_], to: DecoupledIO[_], invalidCondition: Bool): Unit = {
    to.valid := from.valid && !invalidCondition
    from.ready := to.ready && !invalidCondition
  }
  
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Extract instruction from input
  val inst = io.from_ifu.bits.inst

  // Instruction decoding using ListLookup
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Extract register fields
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd = inst(11, 7)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
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
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Array(
    (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),
    (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen),
    (instType === Instructions.TYPE_U) -> SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen),
    (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // Connect outputs
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
