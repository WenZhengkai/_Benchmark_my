import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))         // Sensor inputs (s[3:1])
    val fr3 = Output(Bool())         // Flow output 3
    val fr2 = Output(Bool())         // Flow output 2
    val fr1 = Output(Bool())         // Flow output 1
    val dfr = Output(Bool())         // Supplemental flow output
  })

  // Task 1: State Enumeration Using Ordered Encoding
  object WaterLevel extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value
  }
  import WaterLevel._

  // Task 2: Current State Logic with Default Assignment
  val currentState = WireDefault(WaterLevel.BelowS1)
  when(io.s(2)) {
    currentState := AboveS3  // s[3] asserted → highest water level
  }.elsewhen(io.s(1)) {
    currentState := BetweenS3S2  // s[2] asserted
  }.elsewhen(io.s(0)) {
    currentState := BetweenS2S1  // s[1] asserted
  }

  // Task 3: State Registers and Reset Logic
  val currentStateReg = RegInit(WaterLevel.BelowS1)
  val previousStateReg = RegInit(WaterLevel.BelowS1)

  when(reset.asBool) {
    currentStateReg := WaterLevel.BelowS1
    previousStateReg := WaterLevel.BelowS1
  }.otherwise {
    currentStateReg := currentState
    previousStateReg := currentStateReg
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  io.fr3 := (currentStateReg === WaterLevel.BelowS1)
  io.fr2 := (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)
  io.fr1 := (currentStateReg === WaterLevel.BetweenS3S2) || (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)

  // Task 5: Supplemental Flow Output (dfr)
  val isLevelRising = currentStateReg < previousStateReg  // State enumeration enables numerical comparison
  io.dfr := (currentStateReg === WaterLevel.BelowS1) || isLevelRising
}

// Generate the Verilog code for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
