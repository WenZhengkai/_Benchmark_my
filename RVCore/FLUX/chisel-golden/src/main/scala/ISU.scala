import chisel3._
import chisel3.util._

class ysyx_23060228_RegFile_BlackBox extends BlackBox(Map("DATA_WIDTH" -> MyNPCConfig.XLen)) 
with HasBlackBoxResource 
with HasNPCParameter{
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val rd = Input(UInt(5.W))

    val dest = Input(UInt(XLen.W))
    val RegWrite = Input(Bool())
    val src1 = Output(UInt(XLen.W))
    val src2 = Output(UInt(XLen.W))
  })

  addResource("/vsrc/ysyx_23060228_RegFile_BlackBox.v")
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

class ISU extends NPCModule {

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

class ISU_LLM extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO)) // Instruction information from IDU
    val to_exu = Decoupled(new DecodeIO) // Instruction information to EXU
    val wb = Input(new WbuToRegIO) // Write-back unit feedback
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  //val sb = Module(new ScoreBoard(maxScore))
    val sb = new ScoreBoard(3)  

    def rs1_rs2(rfSrc1 : UInt, rfSrc2 : UInt): (UInt, UInt) = {
        this.io.from_reg.rfSrc1:= rfSrc1
        this.io.from_reg.rfSrc2:= rfSrc2
        (this.io.from_idu.bits.ctrl.rs1 , this.io.from_idu.bits.ctrl.rs2)
    }

  // Data Hazard Detection
  val AnyInvalidCondition = sb.isBusy(io.from_idu.bits.ctrl.rs1) || sb.isBusy(io.from_idu.bits.ctrl.rs2)
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Operand Processing
  val fuSrc1 = MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> io.from_reg.rfSrc1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  val fuSrc2 = MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> io.from_reg.rfSrc2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  io.to_exu.bits := io.from_idu.bits
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  io.to_exu.bits.data.rfSrc1 := io.from_reg.rfSrc1
  io.to_exu.bits.data.rfSrc2 := io.from_reg.rfSrc2
  // Scoreboard Update Logic
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}

