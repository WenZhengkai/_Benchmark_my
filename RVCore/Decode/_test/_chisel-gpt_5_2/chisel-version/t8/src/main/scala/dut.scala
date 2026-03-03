// package npc

import chisel3._
import chisel3.util._

// -------------------------
// Parameters / Base classes
// -------------------------
trait HasNPCParameter {
  def XLen: Int = 64
  def IndependentBru: Boolean = false
}

abstract class NPCBundle(implicit val p: HasNPCParameter) extends Bundle
abstract class NPCModule(implicit val p: HasNPCParameter) extends Module

// -------------------------
// Utility functions
// -------------------------
object Utils {
  def SignExt(a: UInt, len: Int): UInt = {
    val inW = a.getWidth
    require(len >= inW)
    Cat(Fill(len - inW, a(inW - 1)), a)
  }
}

// -------------------------
// Instruction type traits
// -------------------------
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

// -------------------------
// FU type / op / src types
// -------------------------
object FuType extends HasNPCParameter { // Determine which functional unit handles the signal bundle
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru(implicit p: HasNPCParameter) = if (p.IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

object FuOpType { // Determine what operation the functional unit performs on the signal bundle
  def apply() = UInt(7.W)
}

object FuSrcType { // Determine the source operand type required by the functional unit
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply() = UInt(3.W)
}

// Minimal ALUOpType placeholder for DecodeDefault; real meanings live in FU
object ALUOpType {
  def sll = "b0000001".U(7.W)
}

// -------------------------
// Bundles used by dut
// -------------------------
class CtrlFlow(implicit p: HasNPCParameter) extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(p.XLen.W)
  val next_pc  = UInt(p.XLen.W)
  val isBranch = Bool()
}

class CtrlSignal(implicit p: HasNPCParameter) extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()

  val rs1  = UInt(5.W)
  val rs2  = UInt(5.W)
  val rfWen = Bool()
  val rd   = UInt(5.W)
}

class DataSrc(implicit p: HasNPCParameter) extends NPCBundle {
  val fuSrc1        = UInt(p.XLen.W)
  val fuSrc2        = UInt(p.XLen.W)
  val imm           = UInt(p.XLen.W)

  val Alu0Res       = Decoupled(UInt(p.XLen.W))
  val data_from_mem = UInt(p.XLen.W)
  val csrRdata      = UInt(p.XLen.W)
  val rfSrc1        = UInt(p.XLen.W)
  val rfSrc2        = UInt(p.XLen.W)
}

class DecodeIO(implicit p: HasNPCParameter) extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// -------------------------
// Decode tables placeholders
// -------------------------
object RVI_Inst {
  // NOTE: Real project should provide the full decode table here.
  // This placeholder makes the module compile while keeping the requested structure.
  val table: Seq[(BitPat, List[UInt])] = Seq.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = "h00000013".U(32.W)
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// -------------------------
// Handshake helper
// -------------------------
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[_], anyInvalid: Bool): Unit = {
    // Standard 1-stage pass-through handshake; anyInvalid can kill transfer.
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }
}

// -------------------------
// dut
// -------------------------
class dut(implicit p: HasNPCParameter) extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Default assign output payload (avoid latches)
  io.to_isu.bits := 0.U.asTypeOf(new DecodeIO)
  io.to_isu.bits.data <> DontCare // as required: other data sources are DontCare at once

  // Convenience
  val inst = io.from_ifu.bits.inst

  // 2) Instruction decoding
  val decoded = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = decoded

  // 3) Control signal generation
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val isStore = instType === Instructions.TYPE_S
  val opcode  = inst(6, 0)

  val resSrc = WireDefault(0.U(2.W))
  when(opcode === "b0000011".U) {         // Load
    resSrc := 1.U
  }.elsewhen(opcode === "b1110011".U) {   // CSR
    resSrc := 2.U
  }

  // 4) Immediate extension
  import Utils.SignExt

  val immI = SignExt(inst(31, 20), p.XLen)
  val immU = Cat(inst(31, 12), 0.U(12.W)) // upper immediate (already aligned)
  val immJ = SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), p.XLen)
  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), p.XLen)
  val immB = SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), p.XLen)

  val imm = WireDefault(0.U(p.XLen.W))
  switch(instType) {
    is(Instructions.TYPE_I) { imm := immI }
    is(Instructions.TYPE_U) { imm := immU.asUInt } // already XLen-compatible via assignment
    is(Instructions.TYPE_J) { imm := immJ }
    is(Instructions.TYPE_S) { imm := immS }
    is(Instructions.TYPE_B) { imm := immB }
  }

  // 5) Data source preparation
  io.to_isu.bits.data.imm := imm

  // 6) Output connection
  io.to_isu.bits.cf   := io.from_ifu.bits

  io.to_isu.bits.ctrl.MemWrite   := isStore
  io.to_isu.bits.ctrl.ResSrc     := resSrc

  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType     := fuType
  io.to_isu.bits.ctrl.fuOpType   := fuOpType

  io.to_isu.bits.ctrl.rs1        := rs1
  io.to_isu.bits.ctrl.rs2        := rs2
  io.to_isu.bits.ctrl.rd         := rd
  io.to_isu.bits.ctrl.rfWen      := Instructions.isRegWrite(instType)
}
