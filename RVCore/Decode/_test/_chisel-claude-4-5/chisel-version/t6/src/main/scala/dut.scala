import chisel3._
import chisel3.util._

// Trait for instruction types
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

// Control flow bundle
class CtrlFlow(implicit p: NPCConfig) extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Control signal bundle
class CtrlSignal(implicit p: NPCConfig) extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Data source bundle
class DataSrc(implicit p: NPCConfig) extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

// Decode IO bundle
class DecodeIO(implicit p: NPCConfig) extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Functional unit type object
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

// Functional unit operation type
object FuOpType {
  def apply() = UInt(7.W)
}

// Functional unit source type
object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// Instructions object
object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

// Main dut module
class dut(implicit p: NPCConfig) extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // 1. Handshake processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Get instruction from IFU
  val inst = io.from_ifu.bits.inst

  // 2. Instruction decoding
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = 
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // 3. Control signal generation
  val ctrl = Wire(new CtrlSignal)
  
  // Register write enable
  ctrl.rfWen := isRegWrite(instType)
  
  // Extract register fields
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  
  // Memory write enable (S-type instruction)
  ctrl.MemWrite := (instType === TYPE_S)
  
  // Result source select
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,  // Load instruction
    (inst(6, 0) === "b1110011".U) -> 2.U   // CSR operation
  ))
  
  // Source operand types and functional unit info
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // 4. Immediate extension
  val imm = Wire(UInt(XLen.W))
  
  imm := MuxLookup(instType, 0.U)(Seq(
    // I-type: sign-extend 12-bit immediate
    TYPE_I -> SignExt(inst(31, 20), XLen),
    
    // U-type: shift left 12 bits
    TYPE_U -> Cat(inst(31, 12), 0.U(12.W)),
    
    // J-type: 20-bit sign extension
    TYPE_J -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen),
    
    // S-type: 12-bit sign extension
    TYPE_S -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    
    // B-type: 12-bit sign extension
    TYPE_B -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
  ))

  // 5. Data source preparation
  val data = Wire(new DataSrc)
  data <> DontCare
  data.imm := imm

  // 6. Output connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// Helper function for handshake (assuming this exists in your framework)
object HandShakeDeal {
  def apply(from: DecoupledIO[_], to: DecoupledIO[_], invalid: Bool): Unit = {
    from.ready := to.ready
    to.valid := from.valid && !invalid
  }
}

// Sign extension helper (if not already defined)
object SignExt {
  def apply(a: UInt, len: Int): UInt = {
    val aLen = a.getWidth
    val signBit = a(aLen - 1)
    if (aLen >= len) a(len - 1, 0)
    else Cat(Fill(len - aLen, signBit), a)
  }
}
