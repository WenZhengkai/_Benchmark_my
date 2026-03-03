// package npc

import chisel3._
import chisel3.util._

// ------------------------------------------------------------
// Minimal parameter/framework scaffolding (so this file is complete)
// ------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int = 32
  val IndependentBru: Boolean = false
}

abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

// Sign extension helper
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val inW = a.getWidth
    require(len >= inW)
    Cat(Fill(len - inW, a(inW - 1)), a)
  }
}

// Handshake helper
object HandShakeDeal {
  // Basic "pass-through" ready/valid deal; invalid condition can stall by forcing out.valid low.
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[_], anyInvalid: Bool): Unit = {
    in.ready := out.ready && !anyInvalid
    out.valid := in.valid && !anyInvalid
  }
}

// ------------------------------------------------------------
// ISA/Decode related definitions (as required by the spec)
// ------------------------------------------------------------
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

object FuType extends HasNPCParameter { // Determine which functional unit handles the signal bundle
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
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

// A placeholder ALU op type (since the prompt references ALUOpType.sll)
object ALUOpType {
  def sll = "b0000001".U(7.W)
}

// Provide a (possibly empty) decode table container.
// In a real project, replace RVI_Inst.table with the actual decode table.
object RVI_Inst {
  // Table format for ListLookup:
  // Seq( BitPat(inst) -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type), ... )
  val table: Array[(BitPat, List[UInt])] = Array.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// ------------------------------------------------------------
// Bundles (as given in the prompt)
// ------------------------------------------------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width not specified in prompt
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

// ------------------------------------------------------------
// dut
// ------------------------------------------------------------
class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // 2) Instruction decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // 3) Control signal generation
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val rfWen    = isRegWrite(instType)
  val memWrite = instType === TYPE_S
  val resSrc = Mux(inst(6, 0) === "b0000011".U, 1.U, // load
               Mux(inst(6, 0) === "b1110011".U, 2.U, // CSR
                 0.U))

  // 4) Immediate extension
  val immI = SignExt(inst(31, 20), XLen)

  val immU = Cat(inst(31, 12), 0.U(12.W)) // upper immediate << 12 (already XLen after cat in RV32; still fine for RV64 via implicit zero-extend)
  val immUExt = if (XLen == 32) immU else Cat(Fill(XLen - 32, immU(31)), immU) // keep sign behavior consistent if used as signed

  val immJ_20 = Cat(
    inst(31),        // imm[20]
    inst(19, 12),    // imm[19:12]
    inst(20),        // imm[11]
    inst(30, 21),    // imm[10:1]
    0.U(1.W)         // imm[0]
  ) // 21 bits including bit0
  val immJ = SignExt(immJ_20, XLen)

  val immS_12 = Cat(inst(31, 25), inst(11, 7))
  val immS = SignExt(immS_12, XLen)

  val immB_13 = Cat(
    inst(31),        // imm[12]
    inst(7),         // imm[11]
    inst(30, 25),    // imm[10:5]
    inst(11, 8),     // imm[4:1]
    0.U(1.W)         // imm[0]
  ) // 13 bits including bit0
  val immB = SignExt(immB_13, XLen)

  val imm = MuxLookup(instType, 0.U(XLen.W), Array(
    TYPE_I -> immI,
    TYPE_U -> immUExt,
    TYPE_J -> immJ,
    TYPE_S -> immS,
    TYPE_B -> immB
  ))

  // 5) Data source preparation
  val outBits = Wire(new DecodeIO)
  outBits := DontCare

  outBits.data.imm := imm

  // 6) Output connection (CF/CTRL/DATA)
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
