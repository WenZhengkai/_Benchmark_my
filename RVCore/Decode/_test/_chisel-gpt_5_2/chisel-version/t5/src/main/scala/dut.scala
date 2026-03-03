// package npc

import chisel3._
import chisel3.util._

// ================================================================
// Parameters / base classes (minimal stubs to make this file whole)
// ================================================================

trait HasNPCParameter {
  def XLen: Int = 64
  def IndependentBru: Boolean = false
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ================================================================
// Utility
// ================================================================

object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    Cat(Fill(len - aLen, a(aLen - 1)), a)
  }
}

/** Simple pass-through ready/valid deal (no invalid condition used here).
  * This keeps both sides correctly back-pressured.
  */
object HandShakeDeal {
  def apply[T <: Data](from: DecoupledIO[T], to: DecoupledIO[T], anyInvalid: Bool): Unit = {
    // anyInvalid is reserved; in this dut it's always false
    to.valid := from.valid && !anyInvalid
    from.ready := to.ready && !anyInvalid
  }
}

// ================================================================
// ISA decode related definitions
// ================================================================

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

object FuType extends HasNPCParameter {
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
  def apply(): UInt = UInt(log2Up(num).W)
}

object FuOpType {
  def apply(): UInt = UInt(7.W)
}

object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply(): UInt = UInt(3.W)
}

// Minimal ALUOpType symbol used by DecodeDefault in spec.
// (Actual op meaning is defined in the functional unit.)
object ALUOpType {
  def sll = "b0000000".U(7.W)
}

// Minimal decode table placeholder.
// Replace with your real table (e.g., RVI_Inst.table) in your project.
object RVI_Inst {
  // Each entry: BitPat(inst) -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
  val table: Array[(BitPat, List[UInt])] = Array.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// ================================================================
// Bundles (as described; included here to make code complete)
// ================================================================

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt()

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

// ================================================================
// dut
// ================================================================

class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Default output bundle
  io.to_isu.bits := 0.U.asTypeOf(new DecodeIO)
  io.to_isu.bits.data <> DontCare

  // Pass through control-flow info
  io.to_isu.bits.cf := io.from_ifu.bits

  val inst = io.from_ifu.bits.inst

  // 2) Instruction decoding: ListLookup using DecodeTable
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // 3) Control signal generation
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11,  7)

  io.to_isu.bits.ctrl.rs1 := rs1
  io.to_isu.bits.ctrl.rs2 := rs2
  io.to_isu.bits.ctrl.rd  := rd

  io.to_isu.bits.ctrl.rfWen := isRegWrite(instType)

  io.to_isu.bits.ctrl.MemWrite := (instType === TYPE_S)

  // ResSrc: load=1, csr=2, default=0
  val opcode = inst(6, 0)
  io.to_isu.bits.ctrl.ResSrc :=
    Mux(opcode === "b0000011".U, 1.U,
      Mux(opcode === "b1110011".U, 2.U, 0.U))

  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType     := fuType
  io.to_isu.bits.ctrl.fuOpType   := fuOpType

  // 4) Immediate extension to XLen
  val immI = SignExt(inst(31, 20), XLen)

  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)

  // J-type: [20|10:1|11|19:12] << 1, sign-extended
  val immJ_21 = Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)) // 21 bits
  val immJ = SignExt(immJ_21, XLen)

  // S-type: [11:5|4:0]
  val immS_12 = Cat(inst(31, 25), inst(11, 7))
  val immS = SignExt(immS_12, XLen)

  // B-type: [12|10:5|4:1|11] << 1, sign-extended (13 bits total with low 0)
  val immB_13 = Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
  val immB = SignExt(immB_13, XLen)

  val imm = MuxLookup(instType, 0.U(XLen.W), Seq(
    TYPE_I -> immI,
    TYPE_U -> immU,
    TYPE_J -> immJ,
    TYPE_S -> immS,
    TYPE_B -> immB
  ))

  // 5) Data source preparation
  io.to_isu.bits.data.imm := imm
  // Others left as DontCare per spec (already done via io.to_isu.bits.data <> DontCare)

  // 6) Output connection is completed by assignments above:
  // io.to_isu.bits.cf / ctrl / data all connected.
}
