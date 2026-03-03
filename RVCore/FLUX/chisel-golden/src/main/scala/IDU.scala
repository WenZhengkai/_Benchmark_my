import chisel3._
import chisel3.util._


trait  TYPE_INST{
    def TYPE_N = "b0000".U
    def TYPE_I = "b0100".U
    def TYPE_R = "b0101".U
    def TYPE_S = "b0010".U
    def TYPE_B = "b0001".U
    def TYPE_U = "b0110".U
    def TYPE_J = "b0111".U
    

    def isRegWrite(instType : UInt) : Bool = instType(2,2) === 1.U
}

object FuType extends HasNPCParameter{

    def num = 5
    def alu = "b000".U
    def lsu = "b001".U
    def mdu = "b010".U
    def csr = "b011".U
    def mou = "b100".U
    def bru = if(IndependentBru) "b101".U
              else               alu
    def apply() = UInt(log2Up(num).W)
}

object FuOpType{
    def apply() = UInt(7.W)
}

object FuSrcType{
    def rfSrc1 = "b000".U 
    def rfSrc2 = "b001".U 
    def pc     = "b010".U 
    def imm    = "b011".U
    def zero   = "b100".U 
    def four   = "b101".U

    def apply() = UInt(3.W) 
}

object Instructions extends TYPE_INST
with HasNPCParameter
{
    def NOP = 0x00000013.U
    //val DecodeDefault = List(InstrN, FuType.csr, CSROpType.jmp)
    val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
    def DecodeTable = RVI_Inst.table 
}

object TYPE_OPERATOR{

    def SRC1_SRC2 = 0.U 
    def SRC1_IMM  = 1.U 
    def PC_4      = 2.U 
    def PC_IMM    = 3.U 
    def ZERO_IMM  = 4.U 
}
import TYPE_OPERATOR._ 


class CtrlSignal extends NPCBundle {
    // temp
    val MemWrite    = Bool()
    val ResSrc      = UInt()
    // temp
    val fuSrc1Type  = FuSrcType()
    val fuSrc2Type  = FuSrcType()
    val fuType      = FuType()
    val fuOpType    = FuOpType()
    val rs1      = UInt(5.W)
    val rs2      = UInt(5.W)
    val rfWen       = Bool()
    val rd      = UInt(5.W)

}

class DataSrc extends NPCBundle {
    val fuSrc1  = UInt(XLen.W)
    val fuSrc2  = UInt(XLen.W)
    val imm     = UInt(XLen.W)
    // temp
    val Alu0Res  = Decoupled(UInt(XLen.W))
    val data_from_mem =  UInt(XLen.W)
    val csrRdata = UInt(XLen.W)
    val rfSrc1  = UInt(XLen.W)
    val rfSrc2  = UInt(XLen.W)
    // temp
}


class DecodeIO extends NPCBundle {
    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc
}


class IDU extends NPCModule 
with HasNPCParameter
with TYPE_INST
{

    val io = IO(new NPCBundle{
        val from_ifu = Flipped(Decoupled(new CtrlFlow))
        val to_isu = Decoupled(new DecodeIO)
    })

    val AnyInvalidCondition = false.B // TODO: add condition to it
    // ready/valid setted here
    HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition) 


    val inst = io.from_ifu.bits.inst
    val pc  = io.from_ifu.bits.pc

    val data = io.to_isu.bits.data
    val ctrl = io.to_isu.bits.ctrl
    val cf   = io.to_isu.bits.cf


    //>>> Signals >>>
    val to_isu = io.to_isu.bits
    val MemWrite = WireDefault(false.B)
    ctrl.MemWrite := MemWrite
    //val DataToMem = regfile.io.src1
    val ResSrc = WireDefault(0.U)
    ctrl.ResSrc := ResSrc

    

    ctrl.rd := inst(11,7)
    ctrl.rs1 := inst(19,15)     // TODO: unvalid condition
    ctrl.rs2 := inst(24,20)
    val RegWrite = WireDefault(false.B)
    ctrl.rfWen  := RegWrite

    cf <> io.from_ifu.bits

    //<<< Signals <<<

    //>>> Ctrl Signals >>>
    val decodelist = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)         // not recommand, haven't used much
    val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = decodelist

    ctrl.fuOpType := fuOpType
    ctrl.fuType := fuType
    ctrl.fuSrc1Type := fuSrc1Type
    ctrl.fuSrc2Type := fuSrc2Type
    RegWrite := isRegWrite(instType)

    MemWrite := MuxCase(0.U, Array(
        (instType === TYPE_S)   -> 1.U
    ))

    ResSrc := MuxCase(0.U, Array(
        (inst(6,0) === "b0000011".U)    -> 1.U,          // load
        (inst(6,0) === "b1110011".U)    -> 2.U            // csr
    ))
    //<<< Ctrl Signals <<<

    //>>> Immediate Extension >>>
    val ImmExt = MuxLookup(instType, 0.U, Array(
        TYPE_I  -> Cat(Fill(XLen - 12,inst(31)), inst(31,20)),
        TYPE_U  -> (Cat(Fill(XLen - 20, inst(31)), inst(31,12)) << 12)(XLen - 1, 0),    // TODO: use 0.U(12.W)
        //TYPE_U  -> Cat(Fill(XLen - 32, inst(31)), inst(31,12), 0.U(12.W)),
        TYPE_J  -> Cat(Fill(XLen - 21, inst(31)), inst(31), inst(19,12), inst(20), inst(30, 21), 0.U(1.W)),
        TYPE_S  -> Cat(Fill(XLen - 12, inst(31)), inst(31,25), inst(11,7)),
        TYPE_B  -> SignExt(Cat(inst(31),inst(7),inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
    ))

    //<<< Immediate Extension <<<

    //>>> Execute Sources >>>

    data.imm := ImmExt
    data.fuSrc1 := DontCare
    data.fuSrc2 := DontCare
    data.rfSrc1 := DontCare
    data.rfSrc2 := DontCare
    data.Alu0Res := DontCare
    data.data_from_mem := DontCare
    data.csrRdata := DontCare

    //<<< Execute Sources <<<



}

class IDU_LLM extends NPCModule {
  import Instructions._

  // Input/output interface definition
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow)) // Decoupled interface from IFU
    val to_isu = Decoupled(new DecodeIO)           // Decoupled interface to ISU
  })

  // -------------------------------------
  // Task 1: Handshake Processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // -------------------------------------
  // Task 2: Instruction Decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // -------------------------------------
  // Task 3: Control Signal Generation
  val ctrl = Wire(new CtrlSignal)

  ctrl.rfWen := isRegWrite(instType)              // Determine register write enable
  ctrl.rs1 := inst(19, 15)                        // Extract rs1
  ctrl.rs2 := inst(24, 20)                        // Extract rs2
  ctrl.rd := inst(11, 7)                          // Extract rd
  ctrl.MemWrite := (instType === TYPE_S)          // MemWrite for S type instructions
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,         // Load instructions
    (inst(6, 0) === "b1110011".U) -> 2.U          // CSR instructions
  ))
  ctrl.fuSrc1Type := fuSrc1Type                   // Functional unit source 1 type
  ctrl.fuSrc2Type := fuSrc2Type                   // Functional unit source 2 type
  ctrl.fuType := fuType                           // Functional unit type
  ctrl.fuOpType := fuOpType                       // Functional unit operation type

  // -------------------------------------
  // Task 4: Immediate Extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Array(
    (instType === TYPE_I) -> SignExt(inst(31, 20), XLen), // I type
    (instType === TYPE_U) -> SignExt(Cat(inst(31, 12), Fill(12, 0.U)), XLen), // U type
    (instType === TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U), XLen), // J type
    (instType === TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen), // S type
    (instType === TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U), XLen)  // B type
  ))

  // -------------------------------------
  // Task 5: Data Source Preparation
  val data = io.to_isu.bits.data
  data := DontCare
  data.imm := imm                                 // Assign immediate value
  data.rfSrc1 := DontCare                         // Default values for data sources
  data.rfSrc2 := DontCare

  // -------------------------------------
  // Task 6: Output Signal Connection
  io.to_isu.bits.cf := io.from_ifu.bits        // Copy control flow information
  io.to_isu.bits.ctrl := ctrl                     // Connect control signals
  //io.to_isu.bits.data := data                     // Connect data signals
}