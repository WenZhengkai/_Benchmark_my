import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define the Redirect Bundle
class Redirect extends Bundle {
  val target = Output(UInt(XLen.W))
  val valid = Output(Bool())
}

// Define the WbuToRegIO Bundle
class WbuToRegIO extends Bundle {
  val rd = Output(UInt(5.W))
  val Res = Output(UInt(XLen.W))
  val RegWrite = Output(Bool())
}

// Define the CtrlFlow Bundle
class CtrlFlow extends Bundle {
  val inst = Output(UInt(32.W))
  val pc = Output(UInt(XLen.W))
  val next_pc = Output(UInt(XLen.W))
  val isBranch = Output(Bool())
}

// Define the DecodeIO Bundle
class DecodeIO extends Bundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define the CtrlSignal Bundle
class CtrlSignal extends Bundle {
  val MemWrite = Output(Bool())
  val ResSrc = Output(UInt())
  val fuSrc1Type = Output(FuSrcType())
  val fuSrc2Type = Output(FuSrcType())
  val fuType = Output(FuSrcType())
  val fuOpType = Output(FuOpType())
  val rs1 = Output(UInt(5.W))
  val rs2 = Output(UInt(5.W))
  val rfWen = Output(Bool())
  val rd = Output(UInt(5.W))
}

// Define the DataSrc Bundle
class DataSrc extends Bundle {
  val fuSrc1 = Output(UInt(XLen.W))
  val fuSrc2 = Output(UInt(XLen.W))
  val imm = Output(UInt(XLen.W))
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = Output(UInt(XLen.W))
  val csrRdata = Output(UInt(XLen.W))
  val rfSrc1 = Output(UInt(XLen.W))
  val rfSrc2 = Output(UInt(XLen.W))
}

// Define the IFU_LLM2 Module
class IFU_LLM2 extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  // Internal logic for IFU_LLM2
  val pcReg = RegInit(0x80000000.U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // Simple branch prediction logic
  val snpc = pcReg + 4.U
  val predictPc = snpc

  // next_pc calculation logic
  nextPc := MuxCase(pcReg, Seq(
    io.redirect.valid -> io.redirect.target,
    !io.to_idu.ready -> pcReg,
    true.B -> predictPc
  ))

  pcReg := nextPc
  io.pc := pcReg

  // Output logic
  io.to_idu.valid := true.B
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
}

// Define the IDU_LLM2 Module
class IDU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Internal logic for IDU_LLM2
  val instType = Wire(UInt(4.W))
  val fuType = Wire(FuSrcType())
  val fuOpType = Wire(FuOpType())
  val fuSrc1Type = Wire(FuSrcType())
  val fuSrc2Type = Wire(FuSrcType())

  // Instruction decoding
  val inst = io.from_ifu.bits.inst
  val decodeTable = RVI_Inst.table
  val decodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  val decodeResult = ListLookup(inst, decodeDefault, decodeTable)
  instType := decodeResult(0)
  fuType := decodeResult(1)
  fuOpType := decodeResult(2)
  fuSrc1Type := decodeResult(3)
  fuSrc2Type := decodeResult(4)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.MemWrite := instType === TYPE_S
  ctrl.ResSrc := MuxCase(0.U, Seq(
    (inst(6, 0) === "b0000011".U) -> 1.U,
    (inst(6, 0) === "b1110011".U) -> 2.U
  ))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rfWen := isRegWrite(instType)
  ctrl.rd := inst(11, 7)

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Seq(
    (instType === TYPE_I) -> Cat(Fill(XLen - 12, inst(31)), inst(31, 20)),
    (instType === TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
    (instType === TYPE_J) -> Cat(Fill(XLen - 21, inst(31)), inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)),
    (instType === TYPE_S) -> Cat(Fill(XLen - 12, inst(31)), inst(31, 25), inst(11, 7)),
    (instType === TYPE_B) -> Cat(Fill(XLen - 13, inst(31)), inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
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
  io.to_isu.valid := io.from_ifu.valid
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
  io.from_ifu.ready := io.to_isu.ready
}

// Define the ISU_LLM2 Module
class ISU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Internal logic for ISU_LLM2
  val sb = new ScoreBoard(3)
  val anyInvalidCondition = Wire(Bool())
  anyInvalidCondition := sb.isBusy(io.from_idu.bits.ctrl.rs1) || sb.isBusy(io.from_idu.bits.ctrl.rs2)

  // Handshake processing
  HandShakeDeal(io.from_idu, io.to_exu, anyInvalidCondition)

  // Operand processing
  val fuSrc1 = Mux(io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.rfSrc1, io.from_reg.rfSrc1,
    Mux(io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.pc, io.from_idu.bits.cf.pc,
      Mux(io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.zero, 0.U,
        Mux(io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.imm, io.from_idu.bits.data.imm,
          Mux(io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.four, 4.U, 0.U)))))

  val fuSrc2 = Mux(io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.rfSrc2, io.from_reg.rfSrc2,
    Mux(io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.pc, io.from_idu.bits.cf.pc,
      Mux(io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.zero, 0.U,
        Mux(io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.imm, io.from_idu.bits.data.imm,
          Mux(io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.four, 4.U, 0.U)))))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Connect Output
  io.to_exu.bits := io.from_idu.bits
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
}

// Define the dut Module
class dut extends Module {
  val io = IO(new Bundle {
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

  // Instantiate submodules
  val ifu = Module(new IFU_LLM2)
  val idu = Module(new IDU_LLM2)
  val isu = Module(new ISU_LLM2)

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb

  // Register source processing
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}

// Helper function for StageConnect
object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], fire: Bool, flush: Bool): Unit = {
    right.valid := left.valid && !flush
    left.ready := right.ready && !flush
    right.bits := left.bits
  }
}

// Helper function for HandShakeDeal
object HandShakeDeal {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], invalidCondition: Bool): Unit = {
    right.valid := left.valid && !invalidCondition
    left.ready := right.ready && !invalidCondition
    right.bits := left.bits
  }
}

// Helper function for rs1_rs2
object rs1_rs2 {
  def apply(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }
}

// Define the ScoreBoard class
class ScoreBoard(maxScore: Int) extends Module {
  val io = IO(new Bundle {
    val setMask = Input(UInt(NR_GPR.W))
    val clearMask = Input(UInt(NR_GPR.W))
    val isBusy = Output(UInt(NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  // Update logic
  for (i <- 1 until NR_GPR) {
    busy(i) := MuxCase(busy(i), Seq(
      (io.setMask(i) && !io.clearMask(i)) -> Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i)),
      (!io.setMask(i) && io.clearMask(i)) -> Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
    ))
  }

  // Output logic
  io.isBusy := busy.asUInt
}

// Define the main object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
