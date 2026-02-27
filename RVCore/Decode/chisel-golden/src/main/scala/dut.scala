import chisel3._
import chisel3.util._


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
    def SLLI    = if (XLen == 32) BitPat("b0000000?????_?????_001_?????_0010011")
                           else BitPat("b000000??????_?????_001_?????_0010011")
    def SLTI    = BitPat("b????????????_?????_010_?????_0010011")
    def SLTIU   = BitPat("b????????????_?????_011_?????_0010011")
    def XORI    = BitPat("b????????????_?????_100_?????_0010011")
    def SRLI    = if (XLen == 32) BitPat("b0000000?????_?????_101_?????_0010011")
                             else BitPat("b000000??????_?????_101_?????_0010011")
    def ORI     = BitPat("b????????????_?????_110_?????_0010011")
    def ANDI    = BitPat("b????????????_?????_111_?????_0010011")
    def SRAI    = if (XLen == 32) BitPat("b0100000?????_?????_101_?????_0010011")
                           else BitPat("b010000??????_?????_101_?????_0010011")
    

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
        //CSRRC          -> List(TYPE_I, FuType.csr, CSROpType.clr),
        //CSRRWI         -> List(TYPE_I, FuType.csr, CSROpType.wrti),
        //CSRRSI         -> List(TYPE_I, FuType.csr, CSROpType.seti),
        //CSRRCI         -> List(TYPE_I, FuType.csr, CSROpType.clri)
  )
}
object Privileged extends HasNPCParameter
with TYPE_INST {
  def ECALL   = BitPat("b000000000000_00000_000_00000_1110011")
  def EBREAK  = BitPat("b000000000001_00000_000_00000_1110011")
  def MRET    = BitPat("b001100000010_00000_000_00000_1110011")
  def SRET    = BitPat("b000100000010_00000_000_00000_1110011")
  def SFANCE_VMA = BitPat("b0001001_?????_?????_000_00000_1110011")
  def FENCE   = BitPat("b????????????_?????_000_?????_0001111")
  def WFI     = BitPat("b0001000_00101_00000_000_00000_1110011")

/* val table_s = Array(
    SRET           -> List(InstrI, FuType.csr, CSROpType.jmp),
    SFANCE_VMA     -> List(InstrR, FuType.mou, MOUOpType.sfence_vma)
  )
*/
  val table = Array(
    ECALL          -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    EBREAK         -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    MRET           -> List(TYPE_R, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.rfSrc2)
    //FENCE          -> List(InstrS, FuType.mou, MOUOpType.fence), // nop    InstrS -> !wen
    //WFI            -> List(InstrI, FuType.alu, ALUOpType.add) // nop
    // FENCE          -> List(InstrB, FuType.mou, MOUOpType.fencei)
  ) //++ (if (!Settings.get("MmodeOnly")) table_s else Array.empty)
}

object RVI_Inst extends HasNPCParameter {

    val table = RV32I_ALUInst.table ++ RV32I_BRUInst.table ++ RV32I_LSUInst.table ++ RVZicsrInst.table ++ Privileged.table
}


class Decode_golden extends NPCModule 
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