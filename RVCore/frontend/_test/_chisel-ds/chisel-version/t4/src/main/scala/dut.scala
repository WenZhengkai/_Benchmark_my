import chisel3._
import chisel3.util._

// Define constants and parameters
object Constants {
  val XLen = 32
  val NR_GPR = 32
}

// Define Bundle for Redirect
class Redirect extends Bundle {
  val target = UInt(Constants.XLen.W)
  val valid = Bool()
}

// Define Bundle for WbuToRegIO
class WbuToRegIO extends Bundle {
  val rd = UInt(5.W)
  val Res = UInt(Constants.XLen.W)
  val RegWrite = Bool()
}

// Define Bundle for CtrlFlow
class CtrlFlow extends Bundle {
  val inst = UInt(32.W)
  val pc = UInt(Constants.XLen.W)
  val next_pc = UInt(Constants.XLen.W)
  val isBranch = Bool()
}

// Define Bundle for CtrlSignal
class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = UInt(3.W)
  val fuSrc2Type = UInt(3.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(7.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Define Bundle for DataSrc
class DataSrc extends Bundle {
  val fuSrc1 = UInt(Constants.XLen.W)
  val fuSrc2 = UInt(Constants.XLen.W)
  val imm = UInt(Constants.XLen.W)
  val Alu0Res = Decoupled(UInt(Constants.XLen.W))
  val data_from_mem = UInt(Constants.XLen.W)
  val csrRdata = UInt(Constants.XLen.W)
  val rfSrc1 = UInt(Constants.XLen.W)
  val rfSrc2 = UInt(Constants.XLen.W)
}

// Define Bundle for DecodeIO
class DecodeIO extends Bundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define ScoreBoard module
class ScoreBoard(maxScore: Int) extends Module {
  val io = IO(new Bundle {
    val setMask = Input(UInt(Constants.NR_GPR.W))
    val clearMask = Input(UInt(Constants.NR_GPR.W))
    val isBusy = Output(UInt(Constants.NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(Constants.NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  for (i <- 0 until Constants.NR_GPR) {
    when(io.setMask(i) && !io.clearMask(i)) {
      busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
    }.elsewhen(!io.setMask(i) && io.clearMask(i)) {
      busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
    }
  }

  io.isBusy := busy.asUInt
}

// Define IFU module
class IFU extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(Constants.XLen.W))
  })

  val pcReg = RegInit(0x80000000.U(Constants.XLen.W))
  val nextPc = Wire(UInt(Constants.XLen.W))

  // Simple branch prediction logic
  nextPc := pcReg + 4.U

  // Redirect logic
  when(io.redirect.valid) {
    pcReg := io.redirect.target
  }.otherwise {
    pcReg := nextPc
  }

  io.pc := pcReg
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
  io.to_idu.valid := true.B
}

// Define IDU module
class IDU extends Module {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  val inst = io.from_ifu.bits.inst
  val ctrl = Wire(new CtrlSignal)
  val data = Wire(new DataSrc)

  // Decode logic (simplified for demonstration)
  ctrl.MemWrite := false.B
  ctrl.ResSrc := 0.U
  ctrl.fuSrc1Type := "b000".U
  ctrl.fuSrc2Type := "b001".U
  ctrl.fuType := "b000".U
  ctrl.fuOpType := "b0000000".U
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rfWen := true.B
  ctrl.rd := inst(11, 7)

  data.fuSrc1 := 0.U
  data.fuSrc2 := 0.U
  data.imm := 0.U
  data.Alu0Res.valid := false.B
  data.Alu0Res.bits := 0.U
  data.data_from_mem := 0.U
  data.csrRdata := 0.U
  data.rfSrc1 := 0.U
  data.rfSrc2 := 0.U

  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
  io.to_isu.valid := io.from_ifu.valid
  io.from_ifu.ready := io.to_isu.ready
}

// Define ISU module
class ISU extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(Constants.XLen.W))
      val rfSrc2 = Input(UInt(Constants.XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(3))
  val anyInvalidCondition = Wire(Bool())

  // Data hazard detection
  anyInvalidCondition := sb.io.isBusy(io.from_idu.bits.ctrl.rs1) || sb.io.isBusy(io.from_idu.bits.ctrl.rs2)

  // Handshake logic
  io.to_exu.valid := io.from_idu.valid && !anyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !anyInvalidCondition

  // Operand processing
  io.to_exu.bits := io.from_idu.bits
  io.to_exu.bits.data.fuSrc1 := Mux(io.from_idu.bits.ctrl.fuSrc1Type === "b000".U, io.from_reg.rfSrc1, 0.U)
  io.to_exu.bits.data.fuSrc2 := Mux(io.from_idu.bits.ctrl.fuSrc2Type === "b001".U, io.from_reg.rfSrc2, 0.U)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.setMask := isFireSetMask
  sb.io.clearMask := wbuClearMask
}

// Define dut module
class dut extends Module {
  val io = IO(new Bundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(Constants.XLen.W))
    val rfSrc2 = Input(UInt(Constants.XLen.W))
    val pc = Output(UInt(Constants.XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })

  val ifu = Module(new IFU)
  val idu = Module(new IDU)
  val isu = Module(new ISU)

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb
  io.rs1 := isu.io.from_idu.bits.ctrl.rs1
  io.rs2 := isu.io.from_idu.bits.ctrl.rs2

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)

  // Register file connections
  isu.io.from_reg.rfSrc1 := io.rfSrc1
  isu.io.from_reg.rfSrc2 := io.rfSrc2
}

// StageConnect function
object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], fire: Bool, flush: Bool): Unit = {
    right.valid := left.valid && !flush
    left.ready := right.ready && !flush
    right.bits := left.bits
  }
}

// Main object to generate Verilog
/*
object Main extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
