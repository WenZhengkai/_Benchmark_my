// package npc

import chisel3._
import chisel3.util._

/** --------- Minimal framework / helpers (so this file is complete) --------- */
trait HasNPCParameter {
  def XLen: Int = 64
  def IndependentBru: Boolean = false
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// Sign extension helper
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val w = a.getWidth
    require(len >= w)
    Cat(Fill(len - w, a(w - 1)), a)
  }
}

/** Handshake helper: pass-through, with optional invalid kill */
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready && !invalid
  }
}

/** ----------------- Parameters / decode definitions ----------------- */
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

// Placeholder ALU op type (your real design likely has a richer table)
object ALUOpType {
  def sll: UInt = "b0000001".U(7.W)
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

// Minimal decode table provider stub.
// Replace RVI_Inst.table with your real decode table in your project.
object RVI_Inst {
  // Each entry: BitPat(inst) -> List(instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type)
  val table: Array[(BitPat, List[UInt])] = Array(
    // Default NOP (ADDI x0,x0,0) treated as I-type ALU op with zero/zero sources as placeholder
    BitPat("b00000000000000000000000000010011") ->
      List("b0100".U, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  )
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

/** ----------------- Bundles (as described) ----------------- */
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // left as inferred width by assignment
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

/** ----------------- dut ----------------- */
class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  /** 1) Handshake processing */
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  /** Default assignments */
  io.to_isu.bits := 0.U.asTypeOf(new DecodeIO)
  io.to_isu.bits.data <> DontCare // per spec: others DontCare "at once"
  io.to_isu.bits.cf := io.from_ifu.bits

  val inst = io.from_ifu.bits.inst

  /** 2) Instruction decoding (ListLookup) */
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  /** 3) Control signal generation */
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val opcode = inst(6, 0)

  val memWrite = (instType === TYPE_S)
  val resSrc = Mux(opcode === "b0000011".U, 1.U, // LOAD
               Mux(opcode === "b1110011".U, 2.U, // CSR
                 0.U))

  io.to_isu.bits.ctrl.MemWrite   := memWrite
  io.to_isu.bits.ctrl.ResSrc     := resSrc
  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType     := fuType
  io.to_isu.bits.ctrl.fuOpType   := fuOpType
  io.to_isu.bits.ctrl.rs1        := rs1
  io.to_isu.bits.ctrl.rs2        := rs2
  io.to_isu.bits.ctrl.rd         := rd
  io.to_isu.bits.ctrl.rfWen      := isRegWrite(instType)

  /** 4) Immediate extension */
  val immI = SignExt(inst(31, 20), XLen)

  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)

  val immJ_raw = Cat(
    inst(31),        // imm[20]
    inst(19, 12),    // imm[19:12]
    inst(20),        // imm[11]
    inst(30, 21),    // imm[10:1]
    0.U(1.W)         // imm[0]
  )
  val immJ = SignExt(immJ_raw, XLen)

  val immS_raw = Cat(inst(31, 25), inst(11, 7))
  val immS = SignExt(immS_raw, XLen)

  val immB_raw = Cat(
    inst(31),        // imm[12]
    inst(7),         // imm[11]
    inst(30, 25),    // imm[10:5]
    inst(11, 8),     // imm[4:1]
    0.U(1.W)         // imm[0]
  )
  val immB = SignExt(immB_raw, XLen)

  val imm = MuxLookup(instType, 0.U(XLen.W), Array(
    TYPE_I -> immI,
    TYPE_U -> immU,
    TYPE_J -> immJ,
    TYPE_S -> immS,
    TYPE_B -> immB
  ))

  /** 5) Data source preparation */
  io.to_isu.bits.data.imm := imm

  /** 6) Output connection: already wired bundles above
    * - valid/ready handled by HandShakeDeal
    * - bits.cf assigned from IFU
    * - bits.ctrl/data assigned here
    */
}
