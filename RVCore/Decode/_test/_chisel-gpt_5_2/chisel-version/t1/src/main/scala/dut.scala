// package npc.decode

import chisel3._
import chisel3.util._

/** Minimal parameter/utility base (so this file is self-contained).
  * If your project already defines these, you can delete/replace them and keep `dut`.
  */
trait HasNPCParameter {
  def XLen: Int = 64
  def IndependentBru: Boolean = false
}

abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

/** Utilities */
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    require(len >= aLen)
    Cat(Fill(len - aLen, a(aLen - 1)), a)
  }
}

/** Generic ready/valid pass-through handshake helper */
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalid: Bool): Unit = {
    // Basic 1-stage combinational forward (no internal buffering)
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }
}

/** Instruction type encoding */
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

/** FU related encodings */
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

object FuOpType { def apply() = UInt(7.W) }

object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply() = UInt(3.W)
}

/** A placeholder ALU op type for default decode (your project likely has a richer one). */
object ALUOpType {
  def sll = "b0000001".U(7.W)
}

/** Decode table placeholder. Replace with your real RV32I table. */
object RVI_Inst {
  // Table format: Seq[(BitPat, List[UInt...])]
  // List contents must match: instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type
  val table: Array[(BitPat, List[UInt])] = Array(
    // NOP (ADDI x0, x0, 0) as I-type example
    BitPat("b000000000000_00000_000_00000_0010011") ->
      List("b0100".U, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable   = RVI_Inst.table
}

/** Bundles (as specified; included here so the file compiles standalone). */
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width left unspecified in spec; will be inferred by assignments
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()
  val rs1        = UInt(5.W)
  val rs2        = UInt(5.W)
  val rfWen      = Bool()
  val rd         = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1        = UInt(XLen.W)
  val fuSrc2        = UInt(XLen.W)
  val imm           = UInt(XLen.W)
  val Alu0Res       = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata      = UInt(XLen.W)
  val rfSrc1        = UInt(XLen.W)
  val rfSrc2        = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

/** =========================================================
  * Module: dut
  * =========================================================
  */
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // ------------------------------------------------------------
  // 1) Handshake processing
  // ------------------------------------------------------------
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Default drive output bits (payload); valid/ready handled above
  io.to_isu.bits := 0.U.asTypeOf(new DecodeIO)

  // ------------------------------------------------------------
  // 2) Instruction decoding
  // ------------------------------------------------------------
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // ------------------------------------------------------------
  // 3) Control signal generation
  // ------------------------------------------------------------
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val opcode = inst(6, 0)

  val rfWen    = Instructions.isRegWrite(instType)
  val memWrite = instType === Instructions.TYPE_S

  val resSrc = WireDefault(0.U) // 0: ALU/other, 1: MEM, 2: CSR
  when(opcode === "b0000011".U) { // LOAD
    resSrc := 1.U
  }.elsewhen(opcode === "b1110011".U) { // SYSTEM/CSR
    resSrc := 2.U
  }

  // ------------------------------------------------------------
  // 4) Immediate extension
  // ------------------------------------------------------------
  val immI = SignExt(inst(31, 20), XLen)

  val immU = Cat(inst(31, 12), 0.U(12.W))
  val immUext = SignExt(immU, XLen)

  val immJ = Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)) // 21 bits
  val immJext = SignExt(immJ, XLen)

  val immS = Cat(inst(31, 25), inst(11, 7)) // 12 bits
  val immSext = SignExt(immS, XLen)

  val immB = Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)) // 13 bits
  val immBext = SignExt(immB, XLen)

  val imm = WireDefault(0.U(XLen.W))
  switch(instType) {
    is(Instructions.TYPE_I) { imm := immI }
    is(Instructions.TYPE_U) { imm := immUext }
    is(Instructions.TYPE_J) { imm := immJext }
    is(Instructions.TYPE_S) { imm := immSext }
    is(Instructions.TYPE_B) { imm := immBext }
  }

  // ------------------------------------------------------------
  // 5) Data source preparation
  // ------------------------------------------------------------
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // ------------------------------------------------------------
  // 6) Output connection
  // ------------------------------------------------------------
  io.to_isu.bits.cf   := io.from_ifu.bits

  io.to_isu.bits.ctrl.MemWrite   := memWrite
  io.to_isu.bits.ctrl.ResSrc     := resSrc
  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType     := fuType
  io.to_isu.bits.ctrl.fuOpType   := fuOpType
  io.to_isu.bits.ctrl.rs1        := rs1
  io.to_isu.bits.ctrl.rs2        := rs2
  io.to_isu.bits.ctrl.rfWen      := rfWen
  io.to_isu.bits.ctrl.rd         := rd

  io.to_isu.bits.data := data
}
