import chisel3._
import chisel3.util._

trait HasNPCParameter {
  val XLen: Int = 32
  val NR_GPR: Int = 32
  val IndependentBru: Boolean = true
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

trait TYPE_INST {
  def TYPE_N = "b0000".U(4.W)
  def TYPE_B = "b0001".U(4.W)
  def TYPE_S = "b0010".U(4.W)
  def TYPE_I = "b0100".U(4.W)
  def TYPE_R = "b0101".U(4.W)
  def TYPE_U = "b0110".U(4.W)
  def TYPE_J = "b0111".U(4.W)

  def isRegWrite(instType: UInt): Bool = instType(2) === 1.U
}

object FuType extends HasNPCParameter {
  def num = 6
  def alu = "b000".U(3.W)
  def lsu = "b001".U(3.W)
  def mdu = "b010".U(3.W)
  def csr = "b011".U(3.W)
  def mou = "b100".U(3.W)
  def bru = if (IndependentBru) "b101".U(3.W) else alu
  def apply() = UInt(log2Ceil(num).W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

object FuSrcType {
  def rfSrc1 = "b000".U(3.W)
  def rfSrc2 = "b001".U(3.W)
  def pc     = "b010".U(3.W)
  def imm    = "b011".U(3.W)
  def zero   = "b100".U(3.W)
  def four   = "b101".U(3.W)
  def apply() = UInt(3.W)
}

object ALUOpType {
  private def op(x: Int) = x.U(7.W)
  def add  = op(0)
  def sll  = op(1)
  def slt  = op(2)
  def sltu = op(3)
  def xor  = op(4)
  def srl  = op(5)
  def or   = op(6)
  def and  = op(7)
  def sub  = op(8)
  def sra  = op(9)
  def beq  = op(10)
  def bne  = op(11)
  def blt  = op(12)
  def bge  = op(13)
  def bltu = op(14)
  def bgeu = op(15)
}

object LSUOpType {
  private def op(x: Int) = x.U(7.W)
  def sb  = op(0)
  def sh  = op(1)
  def sw  = op(2)
  def lb  = op(3)
  def lh  = op(4)
  def lw  = op(5)
  def lbu = op(6)
  def lhu = op(7)
}

object CSROpType {
  private def op(x: Int) = x.U(7.W)
  def wrt = op(0)
  def set = op(1)
  def jmp = op(2)
}

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)
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

class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

object RV32I_ALUInst extends HasNPCParameter with TYPE_INST {
  def ADDI  = BitPat("b????????????_?????_000_?????_0010011")
  def SLLI  = BitPat("b0000000?????_?????_001_?????_0010011")
  def SLTI  = BitPat("b????????????_?????_010_?????_0010011")
  def SLTIU = BitPat("b????????????_?????_011_?????_0010011")
  def XORI  = BitPat("b????????????_?????_100_?????_0010011")
  def SRLI  = BitPat("b0000000?????_?????_101_?????_0010011")
  def ORI   = BitPat("b????????????_?????_110_?????_0010011")
  def ANDI  = BitPat("b????????????_?????_111_?????_0010011")
  def SRAI  = BitPat("b0100000?????_?????_101_?????_0010011")
  def ADD   = BitPat("b0000000_?????_?????_000_?????_0110011")
  def SLL   = BitPat("b0000000_?????_?????_001_?????_0110011")
  def SLT   = BitPat("b0000000_?????_?????_010_?????_0110011")
  def SLTU  = BitPat("b0000000_?????_?????_011_?????_0110011")
  def XOR   = BitPat("b0000000_?????_?????_100_?????_0110011")
  def SRL   = BitPat("b0000000_?????_?????_101_?????_0110011")
  def OR    = BitPat("b0000000_?????_?????_110_?????_0110011")
  def AND   = BitPat("b0000000_?????_?????_111_?????_0110011")
  def SUB   = BitPat("b0100000_?????_?????_000_?????_0110011")
  def SRA   = BitPat("b0100000_?????_?????_101_?????_0110011")
  def AUIPC = BitPat("b????????????????????_?????_0010111")
  def LUI   = BitPat("b????????????????????_?????_0110111")

  val table = Array(
    ADDI  -> List(TYPE_I, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.imm),
    SLLI  -> List(TYPE_I, FuType.alu, ALUOpType.sll,  FuSrcType.rfSrc1, FuSrcType.imm),
    SLTI  -> List(TYPE_I, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.imm),
    SLTIU -> List(TYPE_I, FuType.alu, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.imm),
    XORI  -> List(TYPE_I, FuType.alu, ALUOpType.xor,  FuSrcType.rfSrc1, FuSrcType.imm),
    SRLI  -> List(TYPE_I, FuType.alu, ALUOpType.srl,  FuSrcType.rfSrc1, FuSrcType.imm),
    ORI   -> List(TYPE_I, FuType.alu, ALUOpType.or,   FuSrcType.rfSrc1, FuSrcType.imm),
    ANDI  -> List(TYPE_I, FuType.alu, ALUOpType.and,  FuSrcType.rfSrc1, FuSrcType.imm),
    SRAI  -> List(TYPE_I, FuType.alu, ALUOpType.sra,  FuSrcType.rfSrc1, FuSrcType.imm),
    ADD   -> List(TYPE_R, FuType.alu, ALUOpType.add,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SLL   -> List(TYPE_R, FuType.alu, ALUOpType.sll,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SLT   -> List(TYPE_R, FuType.alu, ALUOpType.slt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SLTU  -> List(TYPE_R, FuType.alu, ALUOpType.sltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    XOR   -> List(TYPE_R, FuType.alu, ALUOpType.xor,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SRL   -> List(TYPE_R, FuType.alu, ALUOpType.srl,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    OR    -> List(TYPE_R, FuType.alu, ALUOpType.or,   FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    AND   -> List(TYPE_R, FuType.alu, ALUOpType.and,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SUB   -> List(TYPE_R, FuType.alu, ALUOpType.sub,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    SRA   -> List(TYPE_R, FuType.alu, ALUOpType.sra,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    AUIPC -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.pc,     FuSrcType.imm),
    LUI   -> List(TYPE_U, FuType.alu, ALUOpType.add,  FuSrcType.zero,   FuSrcType.imm)
  )
}

object RV32I_BRUInst extends HasNPCParameter with TYPE_INST {
  def JAL  = BitPat("b????????????????????_?????_1101111")
  def JALR = BitPat("b????????????_?????_000_?????_1100111")
  def BEQ  = BitPat("b???????_?????_?????_000_?????_1100011")
  def BNE  = BitPat("b???????_?????_?????_001_?????_1100011")
  def BLT  = BitPat("b???????_?????_?????_100_?????_1100011")
  def BGE  = BitPat("b???????_?????_?????_101_?????_1100011")
  def BLTU = BitPat("b???????_?????_?????_110_?????_1100011")
  def BGEU = BitPat("b???????_?????_?????_111_?????_1100011")

  val table = Array(
    JAL  -> List(TYPE_J, FuType.alu, ALUOpType.add,  FuSrcType.pc,     FuSrcType.four),
    JALR -> List(TYPE_I, FuType.alu, ALUOpType.add,  FuSrcType.pc,     FuSrcType.four),
    BEQ  -> List(TYPE_B, FuType.bru, ALUOpType.beq,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BNE  -> List(TYPE_B, FuType.bru, ALUOpType.bne,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BLT  -> List(TYPE_B, FuType.bru, ALUOpType.blt,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BGE  -> List(TYPE_B, FuType.bru, ALUOpType.bge,  FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BLTU -> List(TYPE_B, FuType.bru, ALUOpType.bltu, FuSrcType.rfSrc1, FuSrcType.rfSrc2),
    BGEU -> List(TYPE_B, FuType.bru, ALUOpType.bgeu, FuSrcType.rfSrc1, FuSrcType.rfSrc2)
  )
}

object RV32I_LSUInst extends HasNPCParameter with TYPE_INST {
  def SB  = BitPat("b???????_?????_?????_000_?????_0100011")
  def SH  = BitPat("b???????_?????_?????_001_?????_0100011")
  def SW  = BitPat("b???????_?????_?????_010_?????_0100011")
  def LB  = BitPat("b????????????_?????_000_?????_0000011")
  def LH  = BitPat("b????????????_?????_001_?????_0000011")
  def LW  = BitPat("b????????????_?????_010_?????_0000011")
  def LBU = BitPat("b????????????_?????_100_?????_0000011")
  def LHU = BitPat("b????????????_?????_101_?????_0000011")

  val table = Array(
    SB  -> List(TYPE_S, FuType.lsu, LSUOpType.sb,  FuSrcType.rfSrc1, FuSrcType.imm),
    SH  -> List(TYPE_S, FuType.lsu, LSUOpType.sh,  FuSrcType.rfSrc1, FuSrcType.imm),
    SW  -> List(TYPE_S, FuType.lsu, LSUOpType.sw,  FuSrcType.rfSrc1, FuSrcType.imm),
    LB  -> List(TYPE_I, FuType.lsu, LSUOpType.lb,  FuSrcType.rfSrc1, FuSrcType.imm),
    LH  -> List(TYPE_I, FuType.lsu, LSUOpType.lh,  FuSrcType.rfSrc1, FuSrcType.imm),
    LW  -> List(TYPE_I, FuType.lsu, LSUOpType.lw,  FuSrcType.rfSrc1, FuSrcType.imm),
    LBU -> List(TYPE_I, FuType.lsu, LSUOpType.lbu, FuSrcType.rfSrc1, FuSrcType.imm),
    LHU -> List(TYPE_I, FuType.lsu, LSUOpType.lhu, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}

object RVZicsrInst extends HasNPCParameter with TYPE_INST {
  def CSRRW = BitPat("b????????????_?????_001_?????_1110011")
  def CSRRS = BitPat("b????????????_?????_010_?????_1110011")

  val table = Array(
    CSRRW -> List(TYPE_I, FuType.csr, CSROpType.wrt, FuSrcType.rfSrc1, FuSrcType.imm),
    CSRRS -> List(TYPE_I, FuType.csr, CSROpType.set, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}

object PrivilegedInst extends HasNPCParameter with TYPE_INST {
  def ECALL  = BitPat("b000000000000_00000_000_00000_1110011")
  def EBREAK = BitPat("b000000000001_00000_000_00000_1110011")
  def MRET   = BitPat("b001100000010_00000_000_00000_1110011")

  val table = Array(
    ECALL  -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    EBREAK -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    MRET   -> List(TYPE_R, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.rfSrc2)
  )
}

object RVI_Inst {
  val table = RV32I_ALUInst.table ++ RV32I_BRUInst.table ++ RV32I_LSUInst.table ++ RVZicsrInst.table ++ PrivilegedInst.table
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP = "h00000013".U(32.W)
  val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = RVI_Inst.table
}

object NPCUtils {
  def SignExt(a: UInt, len: Int): UInt = {
    val w = a.getWidth
    if (w >= len) a(len - 1, 0) else Cat(Fill(len - w, a(w - 1)), a)
  }

  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
    out.bits  := in.bits
    out.valid := in.valid && !anyInvalidCondition
    in.ready  := out.ready && !anyInvalidCondition
  }

  def StageConnect[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], rightOutFire: Bool, flush: Bool): Unit = {
    val _unused = rightOutFire
    right.bits  := left.bits
    right.valid := left.valid && !flush
    left.ready  := right.ready && !flush
  }
}

class IFUIO extends NPCBundle {
  val inst     = Input(UInt(32.W))
  val redirect = Input(new Redirect)
  val to_idu   = Decoupled(new CtrlFlow)
  val pc       = Output(UInt(XLen.W))
}

class IFU_LLM2 extends NPCModule {
  val io = IO(new IFUIO)

  val pcReg = RegInit("h80000000".U(XLen.W))
  val inst  = io.inst
  val opcode = inst(6, 0)

  val isJal    = opcode === "b1101111".U
  val isJalr   = opcode === "b1100111".U
  val isBType  = opcode === "b1100011".U
  val isBranch = isJal || isJalr || isBType

  val isEcall = inst === "b000000000000_00000_000_00000_1110011".U(32.W)
  val isMret  = inst === "b001100000010_00000_000_00000_1110011".U(32.W)
  val noJumpMode = !(isBranch || isEcall || isMret)

  val snpc      = pcReg + 4.U
  val predictPc = snpc
  val jalImm    = Cat(Fill(XLen - 21, inst(31)), inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W))
  val jalTarget = pcReg + jalImm

  val nextPc = WireDefault(pcReg)
  when(io.redirect.valid) {
    nextPc := io.redirect.target
  }.elsewhen(!io.to_idu.ready) {
    nextPc := pcReg
  }.elsewhen(noJumpMode) {
    nextPc := snpc
  }.elsewhen(isJal) {
    nextPc := jalTarget
  }.elsewhen(isJalr || isBType || isEcall || isMret) {
    nextPc := predictPc
  }.otherwise {
    nextPc := pcReg
  }

  pcReg := nextPc

  val validReg = RegInit(true.B)
  validReg := true.B

  io.to_idu.valid := validReg
  io.to_idu.bits.inst := inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := isBranch
  io.pc := pcReg
}

class IDU_LLM2 extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu   = Decoupled(new DecodeIO)
  })

  val AnyInvalidCondition = false.B
  NPCUtils.HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen      := Instructions.isRegWrite(instType)
  ctrl.rs1        := inst(19, 15)
  ctrl.rs2        := inst(24, 20)
  ctrl.rd         := inst(11, 7)
  ctrl.MemWrite   := instType === Instructions.TYPE_S
  ctrl.ResSrc     := Mux(inst(6, 0) === "b0000011".U, 1.U, Mux(inst(6, 0) === "b1110011".U, 2.U, 0.U))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType     := fuType
  ctrl.fuOpType   := fuOpType

  val iImm = NPCUtils.SignExt(inst(31, 20), XLen)
  val uImm = NPCUtils.SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val jImm = NPCUtils.SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  val sImm = NPCUtils.SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val bImm = NPCUtils.SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)

  val imm = WireDefault(0.U(XLen.W))
  switch(instType) {
    is(Instructions.TYPE_I) { imm := iImm }
    is(Instructions.TYPE_U) { imm := uImm }
    is(Instructions.TYPE_J) { imm := jImm }
    is(Instructions.TYPE_S) { imm := sImm }
    is(Instructions.TYPE_B) { imm := bImm }
  }

  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntWidth = log2Ceil(maxScore + 1)
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntWidth.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U
  def mask(idx: UInt): UInt = (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)

  def update(setMask: UInt, clearMask: UInt): Unit = {
    busy(0) := 0.U
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clr = clearMask(i)
      when(set && clr) {
        busy(i) := busy(i)
      }.elsewhen(set) {
        when(busy(i) =/= maxScore.U) { busy(i) := busy(i) + 1.U }
      }.elsewhen(clr) {
        when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

class ISU_LLM2 extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu   = Decoupled(new DecodeIO)
    val wb       = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val inBits = io.from_idu.bits
  val sb = new ScoreBoard(3)

  val needRs1 = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val needRs2 = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  val AnyInvalidCondition = (needRs1 && rs1Busy) || (needRs2 && rs2Busy)
  NPCUtils.HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  val rfSrc1 = io.from_reg.rfSrc1
  val rfSrc2 = io.from_reg.rfSrc2

  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc     -> inBits.cf.pc,
    FuSrcType.zero   -> 0.U(XLen.W)
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm    -> inBits.data.imm,
    FuSrcType.four   -> 4.U(XLen.W)
  ))

  io.to_exu.bits := inBits
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  io.to_exu.bits.data.rfSrc1 := rfSrc1
  io.to_exu.bits.data.rfSrc2 := rfSrc2

  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)

  def rs1_rs2(rfSrc1In: UInt, rfSrc2In: UInt): (UInt, UInt) = {
    io.from_reg.rfSrc1 := rfSrc1In
    io.from_reg.rfSrc2 := rfSrc2In
    (io.from_idu.bits.ctrl.rs1, io.from_idu.bits.ctrl.rs2)
  }
}

class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val redirect    = Input(Bool())
    val inst        = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb          = Input(new WbuToRegIO)
    val rfSrc1      = Input(UInt(XLen.W))
    val rfSrc2      = Input(UInt(XLen.W))

    val pc     = Output(UInt(XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1    = Output(UInt(5.W))
    val rs2    = Output(UInt(5.W))
  })

  val ifu = Module(new IFU_LLM2)
  val idu = Module(new IDU_LLM2)
  val isu = Module(new ISU_LLM2)

  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)

  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb
  io.rs1 := rs1
  io.rs2 := rs2

  NPCUtils.StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  NPCUtils.StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}
