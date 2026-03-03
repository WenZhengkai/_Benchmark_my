import chisel3._
import chisel3.util._

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

object FuType extends HasNPCParameter { // functional unit selector
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = if (IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

object FuOpType { // operation code for selected FU
  def apply() = UInt(7.W)
}

object FuSrcType { // source operand selector for FU inputs
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc     = "b010".U
  def imm    = "b011".U
  def zero   = "b100".U
  def four   = "b101".U
  def apply() = UInt(3.W)
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class dut extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  // 1) Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // 2) Instruction decode
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // 3) Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen      := isRegWrite(instType)
  ctrl.rs1        := inst(19, 15)
  ctrl.rs2        := inst(24, 20)
  ctrl.rd         := inst(11, 7)
  ctrl.MemWrite   := instType === TYPE_S
  ctrl.ResSrc     := MuxLookup(inst(6, 0), 0.U, Array(
    "b0000011".U -> 1.U, // load
    "b1110011".U -> 2.U  // csr
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType

  // 4) Immediate extension
  val immI = SignExt(inst(31, 20), XLen)
  val immU = SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val immJ = SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  val immS = SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val immB = SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)

  val imm = MuxCase(0.U(XLen.W), Seq(
    (instType === TYPE_I) -> immI,
    (instType === TYPE_U) -> immU,
    (instType === TYPE_J) -> immJ,
    (instType === TYPE_S) -> immS,
    (instType === TYPE_B) -> immB
  ))

  // 5) Data source preparation
  val data = Wire(new DataSrc)
  data <> DontCare
  data.imm := imm

  // 6) Output connection
  io.to_isu.bits.cf   := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}
