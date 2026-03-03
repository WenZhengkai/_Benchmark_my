// package npc.core

import chisel3._
import chisel3.util._

/** ---------------------------
  * Minimal framework stubs
  * (If you already have these in your project, you can remove the stubs below
  *  and keep only the dut module.)
  * --------------------------- */

trait HasNPCParameter {
  // Override these in your real project config
  val XLen: Int = 32
  val IndependentBru: Boolean = false
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// Sign extension helper
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    require(len >= a.getWidth)
    Cat(Fill(len - a.getWidth, a(a.getWidth - 1)), a)
  }
}

/** Handshake utility:
  * Pass-through ready/valid with optional invalid condition gating.
  */
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[_], anyInvalid: Bool): Unit = {
    // If invalid: block transfer (out.valid=0, in.ready=0)
    out.valid := in.valid && !anyInvalid
    in.ready := out.ready && !anyInvalid
  }
}

/** ---------------------------
  * Types / enums from spec
  * --------------------------- */

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

// Placeholder ALUOpType so DecodeDefault compiles.
// Replace with your real ALUOpType if already defined.
object ALUOpType {
  def sll: UInt = "b0000000".U(7.W)
}

/** Placeholder decode table provider.
  * Replace with your real RVI_Inst.table in your project.
  */
object RVI_Inst {
  // ListLookup table: Seq[(key, List(values...))]
  // Values: instType, fuType, fuOpType, fuSrc1Type, fuSrc2Type
  def table: Seq[(UInt, List[UInt])] = Seq.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable   = RVI_Inst.table
}

/** ---------------------------
  * I/O bundles
  * --------------------------- */

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width left unspecified in spec; infer by assignments

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()

  val rs1  = UInt(5.W)
  val rs2  = UInt(5.W)
  val rfWen = Bool()
  val rd   = UInt(5.W)
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

/** ---------------------------
  * dut: decoder
  * --------------------------- */
class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  /** 1) Handshake processing */
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  /** Default to avoid latches/undriven */
  io.to_isu.bits := 0.U.asTypeOf(new DecodeIO)
  io.to_isu.bits.data <> DontCare
  io.to_isu.bits.data.Alu0Res.valid := false.B
  io.to_isu.bits.data.Alu0Res.bits  := 0.U

  /** 2) Instruction decoding */
  val inst = io.from_ifu.bits.inst
  val decoded = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = decoded

  /** 3) Control signal generation */
  val rs1 = inst(19, 15)
  val rs2 = inst(24, 20)
  val rd  = inst(11, 7)

  val opcode = inst(6, 0)

  val rfWen    = Instructions.isRegWrite(instType)
  val memWrite = instType === Instructions.TYPE_S

  val resSrc = WireDefault(0.U)
  when(opcode === "b0000011".U) {        // Load
    resSrc := 1.U
  }.elsewhen(opcode === "b1110011".U) {  // CSR
    resSrc := 2.U
  }

  /** 4) Immediate extension */
  val immI = SignExt(inst(31, 20), XLen)

  val immU = Cat(inst(31, 12), 0.U(12.W)) // already aligned; zero-extend by default
  val immU_X = if (XLen > 32) Cat(Fill(XLen - 32, immU(31)), immU) else immU // keep sign-like extension if widened

  val immJ_21 = Cat(
    inst(31),        // imm[20]
    inst(19, 12),    // imm[19:12]
    inst(20),        // imm[11]
    inst(30, 21),    // imm[10:1]
    0.U(1.W)         // imm[0]
  )
  val immJ = SignExt(immJ_21, XLen)

  val immS_12 = Cat(inst(31, 25), inst(11, 7))
  val immS = SignExt(immS_12, XLen)

  val immB_13 = Cat(
    inst(31),        // imm[12]
    inst(7),         // imm[11]
    inst(30, 25),    // imm[10:5]
    inst(11, 8),     // imm[4:1]
    0.U(1.W)         // imm[0]
  )
  val immB = SignExt(immB_13, XLen)

  val imm = WireDefault(0.U(XLen.W))
  switch(instType) {
    is(Instructions.TYPE_I) { imm := immI }
    is(Instructions.TYPE_U) { imm := immU_X }
    is(Instructions.TYPE_J) { imm := immJ }
    is(Instructions.TYPE_S) { imm := immS }
    is(Instructions.TYPE_B) { imm := immB }
  }

  /** 5) Data source preparation */
  // data <> DontCare already done; set imm explicitly
  io.to_isu.bits.data.imm := imm

  /** 6) Output connection */
  // CtrlFlow passthrough
  io.to_isu.bits.cf := io.from_ifu.bits

  // CtrlSignal
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
}
