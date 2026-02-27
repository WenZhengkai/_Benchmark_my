import chisel3._
import chisel3.util._

// Define the NPCModule trait (assuming it exists)
trait NPCModule extends Module {
  def XLen: Int
  def IndependentBru: Boolean
}

// Define the NPCBundle trait (assuming it exists)
trait NPCBundle extends Bundle

// Define the HasNPCParameter trait (assuming it exists)
trait HasNPCParameter {
  def XLen: Int
  def IndependentBru: Boolean
}

// Define the TYPE_INST trait
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

// Define the FuType object
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

// Define the FuOpType object
object FuOpType {
  def apply() = UInt(7.W)
}

// Define the FuSrcType object
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// Define the Instructions object
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table // Assuming RVI_Inst.table is defined elsewhere
}

// Define the CtrlFlow class
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Define the DecodeIO class
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the CtrlSignal class
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define the DataSrc class
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

// Define the dut module
class dut(val XLen: Int, val IndependentBru: Boolean) extends NPCModule {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Instruction decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,
    (inst(6, 0) === "b1110011".U) -> 2.U
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Seq(
    (instType === Instructions.TYPE_I) -> SignExt(Cat(inst(31, 20)), XLen),
    (instType === Instructions.TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen),
    (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data.imm := imm
  data.fuSrc1 := DontCare
  data.fuSrc2 := DontCare
  data.Alu0Res := DontCare
  data.data_from_mem := DontCare
  data.csrRdata := DontCare
  data.rfSrc1 := DontCare
  data.rfSrc2 := DontCare

  // Output connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// Helper function for handshake processing
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready || invalid
    out.bits := in.bits
  }
}

// Helper function for sign extension
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val signBit = a(a.getWidth - 1)
    Cat(Fill(len - a.getWidth, signBit), a)
  }
}
