import chisel3._
import chisel3.util._

trait HasNPCParameter{
  val XLen = 32
  val CONFIG_RVE = true     // Support Riscv E extension
  val NR_GPR = if(CONFIG_RVE) 16 else 32
  val IndependentBru = false

}

abstract class NPCConfig extends HasNPCParameter

object MyNPCConfig extends NPCConfig

abstract class NPCBundle extends Bundle
with HasNPCParameter

abstract class NPCModule extends Module
with HasNPCParameter

class FromMem extends NPCBundle {
  //val inst = Input(UInt(32.W))
  val data = Input(UInt(XLen.W))
}
class ToMem extends NPCBundle {
  val data = Output(UInt(XLen.W))
  val addr = Output(UInt(XLen.W))
  val Wmask= Output(UInt(8.W))
  val MemWrite = Output(Bool())
  //val MemRead = Output(Bool())
}

object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], right_producer_fire: Bool, isFlush: Bool = false.B )   = {
    val arch = "pipeline"
    // 为展示抽象的思想, 此处代码省略了若干细节
    if      (arch == "single")   { 
      right.bits := left.bits 
      right.valid := left.valid
      left.ready := right.ready
    }
    else if (arch == "multi")    { right <> left }
    else if (arch == "pipeline") {
      
      // left.valid : output from combinational
      // right.valid : input from a reg
      val valid = RegInit(false.B)
      when(isFlush) {valid := false.B}
      .elsewhen(right.ready && left.valid) {valid := left.valid}
      .elsewhen(right_producer_fire) {valid := false.B}
      .otherwise {valid := valid}

      right.valid := valid
      left.ready := right.ready
      //right.valid <> RegEnable(left.valid, false.B, right.ready) // Justify it with `wbu_to_reg_valid_reg` at same time
      right.bits <> RegEnable(left.bits, left.valid && right.ready) 
    
    }    // TODO: correct connect
    else if (arch == "ooo")      { right <> Queue(left, 16) }
  }
}

object HandShakeDeal {
  def apply [T1 <: Data,T2 <: Data](consumer: DecoupledIO[T1], producer: DecoupledIO[T2], AnyInvalidCondition: Bool, AnyStopCodition: Bool = false.B) = {
      consumer.ready :=  ((false.B === consumer.valid) || producer.fire) && (false.B === AnyStopCodition ) // TODO: finish it
      producer.valid := consumer.valid && (false.B === AnyInvalidCondition) // TODO: finish it
  }

}

class Commit extends NPCBundle {
  val valid = Bool()
  val pc    = UInt(XLen.W)
  val next_pc    = UInt(XLen.W)   // Todo: abjust it according to jump result
  val inst  = UInt(32.W)
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

object ALUOpType{
    def add  = "b1000000".U
    def sll  = "b0000001".U
    def slt  = "b0000010".U
    def sltu = "b0000011".U
    def xor  = "b0000100".U
    def srl  = "b0000101".U
    def or   = "b0000110".U
    def and  = "b0000111".U
    def sub  = "b0001000".U
    def sra  = "b0001101".U

    def addw = "b1100000".U
    def subw = "b0101000".U
    def sllw = "b0100001".U
    def srlw = "b0100101".U
    def sraw = "b0101101".U

    def isWordOp(func: UInt) = func(5)

    def jal  = "b1011000".U
    def jalr = "b1011010".U
    def beq  = "b0010000".U
    def bne  = "b0010001".U
    def blt  = "b0010100".U
    def bge  = "b0010101".U
    def bltu = "b0010110".U
    def bgeu = "b0010111".U

    // for RAS
    def call = "b1011100".U
    def ret  = "b1011110".U

    def isAdd(func: UInt) = func(6)
    def pcPlus2(func: UInt) = func(5)
    def isBru(func: UInt) = func(4)
    def isBranch(func: UInt) = !func(3)
    def isJump(func: UInt) = isBru(func) && !isBranch(func)
    def getBranchType(func: UInt) = func(2, 1)
    def isBranchInvert(func: UInt) = func(0)
}

object LSUOpType { 
  def lb   = "b0000000".U
  def lh   = "b0000001".U
  def lw   = "b0000010".U
  def ld   = "b0000011".U
  def lbu  = "b0000100".U
  def lhu  = "b0000101".U
  def lwu  = "b0000110".U
  def sb   = "b0001000".U
  def sh   = "b0001001".U
  def sw   = "b0001010".U
  def sd   = "b0001011".U

  def lr      = "b0100000".U
  def sc      = "b0100001".U
  def amoswap = "b0100010".U
  def amoadd  = "b1100011".U
  def amoxor  = "b0100100".U
  def amoand  = "b0100101".U
  def amoor   = "b0100110".U
  def amomin  = "b0110111".U
  def amomax  = "b0110000".U
  def amominu = "b0110001".U
  def amomaxu = "b0110010".U

  def isAdd(func: UInt) = func(6)
  def isAtom(func: UInt): Bool = func(5)
  def isStore(func: UInt): Bool = func(3)
  def isLoad(func: UInt): Bool = !isStore(func) & !isAtom(func)
  def isLR(func: UInt): Bool = func === lr
  def isSC(func: UInt): Bool = func === sc
  def isAMO(func: UInt): Bool = isAtom(func) && !isLR(func) && !isSC(func)

  def needMemRead(func: UInt): Bool = isLoad(func) || isAMO(func) || isLR(func)
  def needMemWrite(func: UInt): Bool = isStore(func) || isAMO(func) || isSC(func)

  def atomW = "010".U
  def atomD = "011".U
  
}

object CSROpType {
  def jmp  = "b000".U
  def wrt  = "b001".U
  def set  = "b010".U
  def clr  = "b011".U
  def wrti = "b101".U
  def seti = "b110".U
  def clri = "b111".U
}


object SignExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth
    val signBit = a(aLen-1)
    if (aLen >= len) a(len-1,0) else Cat(Fill(len - aLen, signBit), a)
  }
}

object ZeroExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth
    if (aLen >= len) a(len-1,0) else Cat(0.U((len - aLen).W), a)
  }
}

class WbuToRegIO extends NPCBundle {

        val rd = UInt(5.W)
        val Res = UInt(XLen.W)
        val RegWrite = Bool()
}


//=== depandency ===
// Generate the Verilog code
object Driver extends App {
  val dir = "generated"
  emitVerilog(new frontend(), Array("--target-dir", dir))
}
