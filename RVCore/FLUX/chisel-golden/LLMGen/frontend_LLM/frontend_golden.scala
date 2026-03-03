import chisel3._
import chisel3.util._

class CtrlFlow extends NPCBundle {
    val inst = UInt(32.W)
    val pc   = UInt(XLen.W)
    val next_pc = UInt(XLen.W)
    val isBranch = Bool()

}

class IFUIO extends NPCBundle {
    val inst = Input(UInt(32.W))
    val pc = Output(UInt(XLen.W))
    val to_idu = Decoupled(new CtrlFlow)
    val redirect = Input(new Redirect)
}

class BruRes extends NPCBundle {
    val valid = Bool()
    val targetPc = UInt(XLen.W)
}

class IFU_LLM2 extends NPCModule with HasNPCParameter{
    val io = IO(new IFUIO)
    val pc = RegInit("h80000000".U(XLen.W))
    val valid = RegInit(true.B)

    val out = io.to_idu

    val inInstOp = io.inst(6,0)
    val inInst   = io.inst

    val isBranch = MuxLookup(inInstOp,false.B, Array(
        "b1101111".U    -> true.B,      /* jal */
        "b1100111".U    -> true.B,      /* jalr */
        "b1100011".U    -> true.B       /* B type */
    ))
    val isEcall = inInst === "b000000000000_00000_000_00000_1110011".U
    val isMret  = inInst === "b0011000_00010_00000_000_00000_1110011".U
    val needBruRes = isBranch || isEcall || isMret
    out.bits.isBranch := isBranch

    //>>> jal branch process
    val jalBruRes = Wire(new BruRes)
    jalBruRes.valid := inInstOp === "b1101111".U
    val isJal = jalBruRes.valid
    val jalImmExt   = Cat(Fill(XLen - 21, inInst(31)), inInst(31), inInst(19,12), inInst(20), inInst(30, 21), 0.U(1.W))
    jalBruRes.targetPc := pc + jalImmExt
    //<<<

    //>>> branch result
    val snpc = pc + 4.U
    val predictPc = snpc 
    // BPU end

    val next_pc =   Mux(io.redirect.valid,      io.redirect.target,
                    Mux(out.ready === false.B,  pc,                 /* stop in back */
                    Mux(needBruRes === false.B, snpc,               /* Instruction is not branch type or trap */
                    Mux(isJal,                  jalBruRes.targetPc,
                    Mux(isJal === false.B,      predictPc,           /* branch, jalr, csr */
                    pc)))))                                         // otherwise
    pc := next_pc

    //>>> io
    io.to_idu.bits.pc := pc
    io.pc := pc
    io.to_idu.bits.inst := io.inst
    io.to_idu.bits.next_pc := next_pc

    
    val AnyInvalidCondition = false.B // TODO: add condition to it
    io.to_idu.valid := valid && (!AnyInvalidCondition)
    //<<< io
    
}

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
object RV32I_ALUInst extends HasNPCParameter 
with TYPE_INST
{

    def ADDI    = BitPat("b????????????_?????_000_?????_0010011")
    def SLLI    = BitPat("b0000000?????_?????_001_?????_0010011")

    def SLTI    = BitPat("b????????????_?????_010_?????_0010011")
    def SLTIU   = BitPat("b????????????_?????_011_?????_0010011")
    def XORI    = BitPat("b????????????_?????_100_?????_0010011")
    def SRLI    = BitPat("b0000000?????_?????_101_?????_0010011")
    def ORI     = BitPat("b????????????_?????_110_?????_0010011")
    def ANDI    = BitPat("b????????????_?????_111_?????_0010011")
    def SRAI    = BitPat("b0100000?????_?????_101_?????_0010011")

    def ADD     = BitPat("b0000000_?????_?????_000_?????_0110011")
    def SLL     = BitPat("b0000000_?????_?????_001_?????_0110011")
    def SLT     = BitPat("b0000000_?????_?????_010_?????_0110011")
    def SLTU    = BitPat("b0000000_?????_?????_011_?????_0110011")
    def XOR     = BitPat("b0000000_?????_?????_100_?????_0110011")
    def SRL     = BitPat("b0000000_?????_?????_101_?????_0110011")
    def OR      = BitPat("b0000000_?????_?????_110_?????_0110011")
    def AND     = BitPat("b0000000_?????_?????_111_?????_0110011")
    def SUB     = BitPat("b0100000_?????_?????_000_?????_0110011")
    def SRA     = BitPat("b0100000_?????_?????_101_?????_0110011")


    def AUIPC   = BitPat("b????????????????????_?????_0010111")
    def LUI     = BitPat("b????????????????????_?????_0110111")

    val table = Array (
        ADDI    -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),
        SLLI    -> List(TYPE_I, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.imm),
        SLTI    -> List(TYPE_I, FuType.alu, ALUOpType.slt, FuSrcType.rfSrc1, FuSrcType.imm),
        SLTIU   -> List(TYPE_I, FuType.alu, ALUOpType.sltu,FuSrcType.rfSrc1, FuSrcType.imm),
        XORI    -> List(TYPE_I, FuType.alu, ALUOpType.xor, FuSrcType.rfSrc1, FuSrcType.imm),
        SRLI    -> List(TYPE_I, FuType.alu, ALUOpType.srl, FuSrcType.rfSrc1, FuSrcType.imm),
        ORI     -> List(TYPE_I, FuType.alu, ALUOpType.or, FuSrcType.rfSrc1, FuSrcType.imm),
        ANDI    -> List(TYPE_I, FuType.alu, ALUOpType.and, FuSrcType.rfSrc1, FuSrcType.imm),
        SRAI    -> List(TYPE_I, FuType.alu, ALUOpType.sra, FuSrcType.rfSrc1, FuSrcType.imm),

        ADD     -> List(TYPE_R, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SLL     -> List(TYPE_R, FuType.alu, ALUOpType.sll, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SLT     -> List(TYPE_R, FuType.alu, ALUOpType.slt, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SLTU    -> List(TYPE_R, FuType.alu, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        XOR     -> List(TYPE_R, FuType.alu, ALUOpType.xor, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SRL     -> List(TYPE_R, FuType.alu, ALUOpType.srl, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        OR      -> List(TYPE_R, FuType.alu, ALUOpType.or, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        AND     -> List(TYPE_R, FuType.alu, ALUOpType.and, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SUB     -> List(TYPE_R, FuType.alu, ALUOpType.sub, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        SRA     -> List(TYPE_R, FuType.alu, ALUOpType.sra, FuSrcType.rfSrc1, FuSrcType.rfSrc2),


        AUIPC   -> List(TYPE_U, FuType.alu, ALUOpType.add, FuSrcType.pc,     FuSrcType.imm),
        LUI     -> List(TYPE_U, FuType.alu, ALUOpType.add, FuSrcType.zero,   FuSrcType.imm)

    )

}

object RV32I_BRUInst extends HasNPCParameter
with TYPE_INST
{
    def JAL     = BitPat("b????????????????????_?????_1101111")
    def JALR    = BitPat("b????????????_?????_000_?????_1100111")

    def BEQ     = BitPat("b???????_?????_?????_000_?????_1100011")
    def BNE     = BitPat("b???????_?????_?????_001_?????_1100011")
    def BLT     = BitPat("b???????_?????_?????_100_?????_1100011")
    def BGE     = BitPat("b???????_?????_?????_101_?????_1100011")
    def BLTU    = BitPat("b???????_?????_?????_110_?????_1100011")
    def BGEU    = BitPat("b???????_?????_?????_111_?????_1100011")

    val table = Array(
        JAL     -> List(TYPE_J, FuType.alu, ALUOpType.add, FuSrcType.pc, FuSrcType.four),
        JALR    -> List(TYPE_I, FuType.alu, ALUOpType.add, FuSrcType.pc, FuSrcType.four),

        BEQ     -> List(TYPE_B, FuType.bru, ALUOpType.beq, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        BNE     -> List(TYPE_B, FuType.bru, ALUOpType.bne, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        BLT     -> List(TYPE_B, FuType.bru, ALUOpType.blt, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        BGE     -> List(TYPE_B, FuType.bru, ALUOpType.bge, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        BLTU    -> List(TYPE_B, FuType.bru, ALUOpType.bltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
        BGEU    -> List(TYPE_B, FuType.bru, ALUOpType.bgeu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    )
}

object RV32I_LSUInst extends HasNPCParameter
with TYPE_INST
{
    def SB      = BitPat("b???????_?????_?????_000_?????_0100011")
    def SH      = BitPat("b???????_?????_?????_001_?????_0100011")
    def SW      = BitPat("b???????_?????_?????_010_?????_0100011")
    
    
    def LB      = BitPat("b????????????_?????_000_?????_0000011")
    def LH      = BitPat("b????????????_?????_001_?????_0000011")
    def LW      = BitPat("b????????????_?????_010_?????_0000011")
    def LBU     = BitPat("b????????????_?????_100_?????_0000011")
    def LHU     = BitPat("b????????????_?????_101_?????_0000011")

    val table = Array(
        SB      -> List(TYPE_S, FuType.lsu, LSUOpType.sb, FuSrcType.rfSrc1, FuSrcType.imm),
        SH      -> List(TYPE_S, FuType.lsu, LSUOpType.sh, FuSrcType.rfSrc1, FuSrcType.imm),
        SW      -> List(TYPE_S, FuType.lsu, LSUOpType.sw, FuSrcType.rfSrc1, FuSrcType.imm),

        LB      -> List(TYPE_I, FuType.lsu, LSUOpType.lb, FuSrcType.rfSrc1, FuSrcType.imm),
        LH      -> List(TYPE_I, FuType.lsu, LSUOpType.lh, FuSrcType.rfSrc1, FuSrcType.imm),
        LW      -> List(TYPE_I, FuType.lsu, LSUOpType.lw, FuSrcType.rfSrc1, FuSrcType.imm),
        LBU     -> List(TYPE_I, FuType.lsu, LSUOpType.lbu, FuSrcType.rfSrc1, FuSrcType.imm),
        LHU     -> List(TYPE_I, FuType.lsu, LSUOpType.lhu, FuSrcType.rfSrc1, FuSrcType.imm)
    )
}

object RVZicsrInst extends HasNPCParameter
with TYPE_INST {
  def CSRRW   = BitPat("b????????????_?????_001_?????_1110011")
  def CSRRS   = BitPat("b????????????_?????_010_?????_1110011")
  def CSRRC   = BitPat("b????????????_?????_011_?????_1110011")
  def CSRRWI  = BitPat("b????????????_?????_101_?????_1110011")
  def CSRRSI  = BitPat("b????????????_?????_110_?????_1110011")
  def CSRRCI  = BitPat("b????????????_?????_111_?????_1110011")

  val table = Array(
        CSRRW          -> List(TYPE_I, FuType.csr, CSROpType.wrt, FuSrcType.rfSrc1, FuSrcType.imm),
        CSRRS          -> List(TYPE_I, FuType.csr, CSROpType.set, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}
object Privileged extends HasNPCParameter
with TYPE_INST {
  def ECALL   = BitPat("b000000000000_00000_000_00000_1110011")
  def EBREAK  = BitPat("b000000000001_00000_000_00000_1110011")
  def MRET    = BitPat("b001100000010_00000_000_00000_1110011")


  val table = Array(
    ECALL          -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    EBREAK         -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    MRET           -> List(TYPE_R, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.rfSrc2)

  ) 
}

object RVI_Inst extends HasNPCParameter {

    val table = RV32I_ALUInst.table ++ RV32I_BRUInst.table ++ RV32I_LSUInst.table ++ RVZicsrInst.table ++ Privileged.table
}

class IDU_LLM2 extends NPCModule with HasNPCParameter
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

class ScoreBoard(maxScore : Int) extends HasNPCParameter {
    val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore).W))))
    def isBusy(idx: UInt) : Bool = (busy(idx) =/= 0.U)
    def mask (idx: UInt) : UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
    def update (setMask: UInt, clearMask: UInt) = {
        busy(0) := 0.U
        for (idx <- 1 until NR_GPR) {
            when(setMask(idx) && clearMask(idx)) {
                busy(idx) := busy(idx)
            }.elsewhen(setMask(idx)) {
                busy(idx) := Mux(busy(idx) === maxScore.U, maxScore.U, busy(idx) + 1.U)
            }.elsewhen(clearMask(idx)) {
                busy(idx) := Mux(busy(idx) === 0.U, 0.U, busy(idx) - 1.U)
            }.otherwise {
                busy(idx) := busy(idx)
            }
        }
    }
}

class ISU_LLM2 extends NPCModule with HasNPCParameter {

    val io = IO(new Bundle{
        val from_idu = Flipped(Decoupled(new DecodeIO))
        val to_exu   = Decoupled(new DecodeIO)
        val wb = Input(new WbuToRegIO)
        val from_reg = new Bundle {
            val rfSrc1 = Input(UInt(XLen.W))
            val rfSrc2 = Input(UInt(XLen.W))
        }
    })

    val sb = new ScoreBoard(3)      // TODO: deside the max score based on number of backend pipeline

    val inBits = io.from_idu.bits
    val out    = io.to_exu

    val src1Busy = sb.isBusy(inBits.ctrl.rs1)
    val src2Busy = sb.isBusy(inBits.ctrl.rs2)
    val dataHazard = (src1Busy || src2Busy)
    val AnyInvalidCondition = dataHazard // TODO: add condition to it
    // ready/valid setted here
    HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition) 

    def rs1_rs2(rfSrc1 : UInt, rfSrc2 : UInt): (UInt, UInt) = {
        this.io.from_reg.rfSrc1:= rfSrc1
        this.io.from_reg.rfSrc2:= rfSrc2
        (this.outBits.ctrl.rs1 , this.outBits.ctrl.rs2)
    }

    val outBits = io.to_exu.bits
    outBits.cf <> inBits.cf
    outBits.ctrl <> inBits.ctrl

    outBits.data <> inBits.data
    // override outBits.data.rfSrc2
    val (rfSrc1,rfSrc2) = (io.from_reg.rfSrc1, io.from_reg.rfSrc2)
    outBits.data.rfSrc1 := rfSrc1
    outBits.data.rfSrc2 := rfSrc2
   

    outBits.data.fuSrc1 := MuxLookup(inBits.ctrl.fuSrc1Type, 0.U, Array(
        FuSrcType.rfSrc1    -> rfSrc1,
        FuSrcType.pc        -> inBits.cf.pc,
        FuSrcType.zero      -> 0.U
    ))
    outBits.data.fuSrc2 := MuxLookup(inBits.ctrl.fuSrc2Type, 0.U, Array(
        FuSrcType.rfSrc2    -> rfSrc2,
        FuSrcType.imm       -> inBits.data.imm,
        FuSrcType.four      -> 4.U
    ))
    


    //>>>Deal Data Hazard with ScoreBoard


    val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)        // TODO: selector need consider forward
    val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)

    sb.update(isFireSetMask, wbuClearMask)

    //<<<Deal Data Hazard with ScoreBoard

}

class frontend extends NPCModule {
    val io =IO(new NPCBundle{
        // top
        val redirect = Input(Bool())
        // ifu
        val inst = Input(UInt(32.W))
        val pc = Output(UInt(XLen.W))
        val ifuredirect = Input(new Redirect)
        // isu
        val to_exu = Decoupled(new DecodeIO)
        val wb = Input(new WbuToRegIO)
        val rfSrc1 = Input(UInt(XLen.W))
        val rfSrc2 = Input(UInt(XLen.W))
        val rs1    = Output(UInt(5.W))
        val rs2    = Output(UInt(5.W))
    })
    val ifu = Module(new IFU_LLM2)
    val idu = Module(new IDU_LLM2)
    val isu = Module(new ISU_LLM2)

    ifu.io.inst := io.inst
    io.pc       := ifu.io.pc
    ifu.io.redirect := io.ifuredirect
    io.to_exu   <> isu.io.to_exu
    isu.io.wb   := io.wb
    val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
    io.rs1 := rs1
    io.rs2 := rs2

    def rs1_rs2(rfSrc1 : UInt, rfSrc2 : UInt): (UInt, UInt) = {
        this.io.rfSrc1:= rfSrc1
        this.io.rfSrc2:= rfSrc2
        (this.io.rs1 , this.io.rs2)
    }
    

    StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
    StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)

}