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


//=== depandency ===

object HandShakeDeal {
  def apply [T1 <: Data,T2 <: Data](consumer: DecoupledIO[T1], producer: DecoupledIO[T2], AnyInvalidCondition: Bool, AnyStopCodition: Bool = false.B) = {
      consumer.ready :=  ((false.B === consumer.valid) || producer.fire) && (false.B === AnyStopCodition ) // TODO: finish it
      producer.valid := consumer.valid && (false.B === AnyInvalidCondition) // TODO: finish it
  }

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

class CtrlFlow extends NPCBundle {
    val inst = UInt(32.W)
    val pc   = UInt(XLen.W)
    val next_pc = UInt(XLen.W)
    val isBranch = Bool()

}

class CtrlSignal extends NPCBundle {
    // temp
    val MemWrite    = Bool()
    val ResSrc      = UInt(4.W)
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

class WbuToRegIO extends NPCBundle {

        val rd = UInt(5.W)
        val Res = UInt(XLen.W)
        val RegWrite = Bool()
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

class issue_golden extends NPCModule {

    val io = IO(new Bundle{
        val from_idu = Flipped(Decoupled(new DecodeIO))
        val to_exu   = Decoupled(new DecodeIO)
        val wb = Input(new WbuToRegIO)
        val from_reg = new Bundle {
            val rfSrc1 = Input(UInt(XLen.W))
            val rfSrc2 = Input(UInt(XLen.W))
        }
        
        //wb, forward, flush
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

    //io.to_exu <> io.from_idu
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