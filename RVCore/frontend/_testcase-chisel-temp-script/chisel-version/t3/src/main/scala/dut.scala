import chisel3._
import chisel3.util._

trait HasNPCParameter {
  final val XLen: Int = 32
  final val NR_GPR: Int = 32
  final val IndependentBru: Boolean = true
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

trait TYPE_INST {
  def TYPE_N: UInt = "b0000".U(4.W)
  def TYPE_B: UInt = "b0001".U(4.W)
  def TYPE_S: UInt = "b0010".U(4.W)
  def TYPE_I: UInt = "b0100".U(4.W)
  def TYPE_R: UInt = "b0101".U(4.W)
  def TYPE_U: UInt = "b0110".U(4.W)
  def TYPE_J: UInt = "b0111".U(4.W)

  def isRegWrite(instType: UInt): Bool = instType(2) === 1.U
}

object FuType extends HasNPCParameter {
  def num: Int = 6
  def alu: UInt = "b000".U(3.W)
  def lsu: UInt = "b001".U(3.W)
  def mdu: UInt = "b010".U(3.W)
  def csr: UInt = "b011".U(3.W)
  def mou: UInt = "b100".U(3.W)
  def bru: UInt = if (IndependentBru) "b101".U(3.W) else alu
  def apply(): UInt = UInt(log2Ceil(num).W)
}

object FuOpType {
  def apply(): UInt = UInt(7.W)
}

object FuSrcType {
  def rfSrc1: UInt = "b000".U(3.W)
  def rfSrc2: UInt = "b001".U(3.W)
  def pc: UInt = "b010".U(3.W)
  def imm: UInt = "b011".U(3.W)
  def zero: UInt = "b100".U(3.W)
  def four: UInt = "b101".U(3.W)
  def apply(): UInt = UInt(3.W)
}

object ALUOpType {
  def add: UInt = 0.U(7.W)
  def sll: UInt = 1.U(7.W)
  def slt: UInt = 2.U(7.W)
  def sltu: UInt = 3.U(7.W)
  def xor: UInt = 4.U(7.W)
  def srl: UInt = 5.U(7.W)
  def or: UInt = 6.U(7.W)
  def and: UInt = 7.U(7.W)
  def sub: UInt = 8.U(7.W)
  def sra: UInt = 9.U(7.W)
  def beq: UInt = 10.U(7.W)
  def bne: UInt = 11.U(7.W)
  def blt: UInt = 12.U(7.W)
  def bge: UInt = 13.U(7.W)
  def bltu: UInt = 14.U(7.W)
  def bgeu: UInt = 15.U(7.W)
}

object LSUOpType {
  def sb: UInt = 32.U(7.W)
  def sh: UInt = 33.U(7.W)
  def sw: UInt = 34.U(7.W)
  def lb: UInt = 35.U(7.W)
  def lh: UInt = 36.U(7.W)
  def lw: UInt = 37.U(7.W)
  def lbu: UInt = 38.U(7.W)
  def lhu: UInt = 39.U(7.W)
}

object CSROpType {
  def wrt: UInt = 48.U(7.W)
  def set: UInt = 49.U(7.W)
  def jmp: UInt = 50.U(7.W)
}

object Utils extends HasNPCParameter {
  def SignExt(a: UInt, len: Int): UInt = {
    if (a.getWidth >= len) a(len - 1, 0)
    else Cat(Fill(len - a.getWidth, a(a.getWidth - 1)), a)
  }

  def HandShakeDeal[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], anyInvalidCondition: Bool): Unit = {
    out.bits := in.bits
    out.valid := in.valid && !anyInvalidCondition
    in.ready := out.ready && !anyInvalidCondition
  }

  def StageConnect[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], rightFire: Bool, flush: Bool): Unit = {
    right.bits := left.bits
    right.valid := left.valid && !flush
    left.ready := right.ready && !flush
    dontTouch(rightFire)
  }
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
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

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
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

  val table: Array[(BitPat, List[UInt])] = Array(
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

  val table: Array[(BitPat, List[UInt])] = Array(
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

  val table: Array[(BitPat, List[UInt])] = Array(
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

  val table: Array[(BitPat, List[UInt])] = Array(
    CSRRW -> List(TYPE_I, FuType.csr, CSROpType.wrt, FuSrcType.rfSrc1, FuSrcType.imm),
    CSRRS -> List(TYPE_I, FuType.csr, CSROpType.set, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}

object PrivilegedInst extends HasNPCParameter with TYPE_INST {
  def ECALL  = BitPat("b000000000000_00000_000_00000_1110011")
  def EBREAK = BitPat("b000000000001_00000_000_00000_1110011")
  def MRET   = BitPat("b001100000010_00000_000_00000_1110011")

  val table: Array[(BitPat, List[UInt])] = Array(
    ECALL  -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    EBREAK -> List(TYPE_I, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.imm),
    MRET   -> List(TYPE_R, FuType.csr, CSROpType.jmp, FuSrcType.rfSrc1, FuSrcType.rfSrc2)
  )
}

object RVI_Inst extends HasNPCParameter {
  val table: Array[(BitPat, List[UInt])] =
    RV32I_ALUInst.table ++ RV32I_BRUInst.table ++ RV32I_LSUInst.table ++ RVZicsrInst.table ++ PrivilegedInst.table
}

object Instructions extends TYPE_INST with HasNPCParameter {
  def NOP: UInt = "h00000013".U(32.W)
  val DecodeDefault: List[UInt] = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable: Array[(BitPat, List[UInt])] = RVI_Inst.table
}

class IFUIO extends NPCBundle {
  val inst = Input(UInt(32.W))
  val redirect = Input(new Redirect)
  val to_idu = Decoupled(new CtrlFlow)
  val pc = Output(UInt(XLen.W))
}

class IFU_LLM2 extends NPCModule {
  val io = IO(new IFUIO)

  val pcReg = RegInit("h80000000".U(XLen.W))
  val validReg = RegInit(true.B)

  val opcode = io.inst(6, 0)
  val isJal = opcode === "b1101111".U
  val isJalr = opcode === "b1100111".U
  val isBType = opcode === "b1100011".U
  val isJump = isJal || isJalr || isBType

  val isEcall = io.inst === "b00000000000000000000000001110011".U(32.W)
  val isMret = io.inst === "b00110000001000000000000001110011".U(32.W)
  val noJumpMode = !(isJump || isEcall || isMret)

  val jalOffset = Cat(
    Fill(XLen - 21, io.inst(31)),
    io.inst(31),
    io.inst(19, 12),
    io.inst(20),
    io.inst(30, 21),
    0.U(1.W)
  )
  val jalTarget = pcReg + jalOffset

  val snpc = pcReg + 4.U
  val predictPc = snpc

  val nextPc = MuxCase(pcReg, Seq(
    io.redirect.valid -> io.redirect.target,
    (!io.to_idu.ready) -> pcReg,
    noJumpMode -> snpc,
    isJal -> jalTarget,
    isJump -> predictPc
  ))

  pcReg := nextPc

  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := isJump
  io.to_idu.valid := validReg

  io.pc := pcReg
}

class IDU_LLM2 extends NPCModule with TYPE_INST {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  val AnyInvalidCondition = false.B
  Utils.HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := instType === TYPE_S
  ctrl.ResSrc := MuxLookup(inst(6, 0), 0.U(2.W), Seq(
    "b0000011".U -> 1.U(2.W),
    "b1110011".U -> 2.U(2.W)
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  val iImm = Utils.SignExt(inst(31, 20), XLen)
  val uImm = Utils.SignExt(Cat(inst(31, 12), 0.U(12.W)), XLen)
  val jImm = Utils.SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen)
  val sImm = Utils.SignExt(Cat(inst(31, 25), inst(11, 7)), XLen)
  val bImm = Utils.SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)

  val imm = MuxLookup(instType, 0.U(XLen.W), Seq(
    TYPE_I -> iImm,
    TYPE_U -> uImm,
    TYPE_J -> jImm,
    TYPE_S -> sImm,
    TYPE_B -> bImm
  ))

  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val scoreW = log2Ceil(maxScore + 1).max(1)
  private val maxVal = maxScore.U(scoreW.W)

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U

  def mask(idx: UInt): UInt = {
    val m = Wire(UInt(NR_GPR.W))
    m := (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
    m
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U
      } else {
        val set = setMask(i)
        val clr = clearMask(i)
        when(set && clr) {
          busy(i) := busy(i)
        }.elsewhen(set) {
          when(busy(i) =/= maxVal) { busy(i) := busy(i) + 1.U }
        }.elsewhen(clr) {
          when(busy(i) =/= 0.U) { busy(i) := busy(i) - 1.U }
        }
      }
    }
  }
}

class ISU_LLM2 extends NPCModule {
  val io = IO(new NPCBundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
  })

  private val rfSrc1Wire = WireDefault(0.U(XLen.W))
  private val rfSrc2Wire = WireDefault(0.U(XLen.W))

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    rfSrc1Wire := rfSrc1
    rfSrc2Wire := rfSrc2
    (io.from_idu.bits.ctrl.rs1, io.from_idu.bits.ctrl.rs2)
  }

  val sb = new ScoreBoard(3)
  val inBits = io.from_idu.bits

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  Utils.HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  io.to_exu.bits := inBits

  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc1 -> rfSrc1Wire,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U(XLen.W)
  ))

  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U(XLen.W), Seq(
    FuSrcType.rfSrc2 -> rfSrc2Wire,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U(XLen.W)
  ))

  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  io.to_exu.bits.data.rfSrc1 := rfSrc1Wire
  io.to_exu.bits.data.rfSrc2 := rfSrc2Wire

  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(sb.NR_GPR.W))
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(sb.NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}

class dut extends NPCModule {
  val io = IO(new NPCBundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))

    val pc = Output(UInt(XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
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

  Utils.StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  Utils.StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}
