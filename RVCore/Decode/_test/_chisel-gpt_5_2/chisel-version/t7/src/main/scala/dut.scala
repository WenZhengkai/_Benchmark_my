// package npc

import chisel3._
import chisel3.util._

// ============================================================
// Parameter / Base definitions (minimal to make this module complete)
// ============================================================

trait HasNPCParameter {
  val XLen: Int = 64
  val IndependentBru: Boolean = true
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ============================================================
// Helper functions
// ============================================================

object Utils {
  def SignExt(a: UInt, len: Int): UInt = {
    val w = a.getWidth
    require(len >= w, s"SignExt target len($len) must be >= src width($w)")
    Cat(Fill(len - w, a(w - 1)), a)
  }
}

// Simple pass-through handshake with optional invalidation.
// If invalidCond is true, downstream valid will be forced low.
object HandShakeDeal {
  def apply(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    out.valid := in.valid && !invalidCond
    in.ready  := out.ready && !invalidCond
  }
}

// ============================================================
// Instruction type / decode related definitions
// ============================================================

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

object FuType extends HasNPCParameter { // which functional unit
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

object FuOpType { // which operation inside FU
  def apply() = UInt(7.W)
}

object FuSrcType { // operand source type
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply() = UInt(3.W)
}

// Placeholder ALU op type used by DecodeDefault (actual meaning inside ALU)
object ALUOpType {
  def sll = 0.U(7.W)
}

// Placeholder decode table source; replace with your real table provider.
object RVI_Inst {
  // Each entry: BitPat(inst) -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
  val table: Array[(BitPat, List[UInt])] = Array.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable   = RVI_Inst.table
}

// ============================================================
// Bundles
// ============================================================

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // left unspecified width in spec; we choose 2 bits in the module

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

// ============================================================
// dut: Instruction Decode Unit
// ============================================================

class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Latch/forward payload combinationally; handshake gating is handled above
  val inst = io.from_ifu.bits.inst

  // 2) Instruction decoding via ListLookup
  val decoded = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = decoded

  // 3) Control signal generation
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val opcode = inst(6, 0)

  val memWrite = instType === TYPE_S

  // ResSrc: 0=ALU/normal, 1=Load, 2=CSR
  val resSrc = WireDefault(0.U(2.W))
  when(opcode === "b0000011".U) { // LOAD
    resSrc := 1.U
  }.elsewhen(opcode === "b1110011".U) { // SYSTEM/CSR
    resSrc := 2.U
  }

  val rfWen = isRegWrite(instType)

  // 4) Immediate extension (RISCV32I style), extended to XLen
  import Utils._

  val immI = SignExt(inst(31, 20), XLen)

  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)

  // J-type: imm[20|10:1|11|19:12|0]
  val immJ = SignExt(
    Cat(
      inst(31),        // imm[20]
      inst(19, 12),    // imm[19:12]
      inst(20),        // imm[11]
      inst(30, 21),    // imm[10:1]
      0.U(1.W)         // imm[0]
    ),
    XLen
  )

  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)

  // B-type: imm[12|10:5|4:1|11|0]
  val immB = SignExt(
    Cat(
      inst(31),        // imm[12]
      inst(7),         // imm[11]
      inst(30, 25),    // imm[10:5]
      inst(11, 8),     // imm[4:1]
      0.U(1.W)         // imm[0]
    ),
    XLen
  )

  val imm = WireDefault(0.U(XLen.W))
  switch(instType) {
    is(TYPE_I) { imm := immI }
    is(TYPE_U) { imm := immU }
    is(TYPE_J) { imm := immJ }
    is(TYPE_S) { imm := immS }
    is(TYPE_B) { imm := immB }
  }

  // 5) Data source preparation
  val outBits = Wire(new DecodeIO)
  outBits := DontCare

  outBits.data.imm := imm

  // keep decoupled sub-channel safe by default
  outBits.data.Alu0Res.valid := false.B
  outBits.data.Alu0Res.bits  := 0.U

  // 6) Output connection: cf/ctrl/data bundles
  outBits.cf := io.from_ifu.bits

  outBits.ctrl.MemWrite   := memWrite
  outBits.ctrl.ResSrc     := resSrc
  outBits.ctrl.fuSrc1Type := fuSrc1Type
  outBits.ctrl.fuSrc2Type := fuSrc2Type
  outBits.ctrl.fuType     := fuType
  outBits.ctrl.fuOpType   := fuOpType
  outBits.ctrl.rs1        := rs1
  outBits.ctrl.rs2        := rs2
  outBits.ctrl.rfWen      := rfWen
  outBits.ctrl.rd         := rd

  io.to_isu.bits := outBits
}
