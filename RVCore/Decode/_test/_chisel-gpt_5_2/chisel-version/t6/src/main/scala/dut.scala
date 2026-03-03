// package npc

import chisel3._
import chisel3.util._

/** -------- Parameters / base types (minimal stubs to make this file complete) -------- */
trait HasNPCParameter {
  val XLen: Int = 64
  val IndependentBru: Boolean = false
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

/** -------- Utility helpers -------- */
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    require(len >= a.getWidth)
    Cat(Fill(len - a.getWidth, a(a.getWidth - 1)), a)
  }
}

/** Simple pass-through handshake wiring:
  * out.valid := in.valid && !invalid
  * in.ready  := out.ready
  */
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[_], anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    in.ready := out.ready
  }
}

/** -------- ISA / decode definitions -------- */
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
  // Determine which functional unit handles the signal bundle
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
  def apply(): UInt = UInt(log2Up(num).W)
}

object FuOpType { // Determine what operation the functional unit performs
  def apply(): UInt = UInt(7.W)
}

object FuSrcType { // Determine the source operand type
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply(): UInt = UInt(3.W)
}

// Minimal ALU op type placeholder; real design should define full opcodes
object ALUOpType {
  def sll: UInt = "b0000001".U(7.W)
}

/** Decode table placeholder (you should replace with your real RVI_Inst.table). */
object RVI_Inst {
  val table: Seq[(BitPat, List[UInt])] = Seq.empty
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

/** -------- Bundles from the spec -------- */
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width not specified; keep as UInt()

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

/** -------- dut -------- */
class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  /** 1) Handshake processing */
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  /** 2) Instruction decoding */
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  /** 3) Control signal generation */
  val ctrl = Wire(new CtrlSignal)
  ctrl := DontCare

  ctrl.rs1   := inst(19, 15)
  ctrl.rs2   := inst(24, 20)
  ctrl.rd    := inst(11, 7)
  ctrl.rfWen := isRegWrite(instType)

  ctrl.MemWrite := (instType === TYPE_S)

  // ResSrc: 0=ALU/normal, 1=load, 2=CSR
  val opcode = inst(6, 0)
  ctrl.ResSrc := Mux(opcode === "b0000011".U, 1.U,
                 Mux(opcode === "b1110011".U, 2.U, 0.U))

  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType

  /** 4) Immediate extension */
  val immI = SignExt(inst(31, 20), XLen)

  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)

  // J-type: imm[20|10:1|11|19:12|0]
  val immJ_21 = Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W))
  val immJ    = SignExt(immJ_21, XLen)

  // S-type: imm[11:5|4:0]
  val immS_12 = Cat(inst(31, 25), inst(11, 7))
  val immS    = SignExt(immS_12, XLen)

  // B-type: imm[12|10:5|4:1|11|0]
  val immB_13 = Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
  val immB    = SignExt(immB_13, XLen)

  val imm = Wire(UInt(XLen.W))
  imm := 0.U
  switch(instType) {
    is(TYPE_I) { imm := immI }
    is(TYPE_U) { imm := immU }
    is(TYPE_J) { imm := immJ }
    is(TYPE_S) { imm := immS }
    is(TYPE_B) { imm := immB }
  }

  /** 5) Data source preparation */
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  /** 6) Output connection */
  io.to_isu.bits.cf   := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
