import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))     // 3-bit sensor inputs
    val fr3 = Output(Bool())     // Nominal flow signal 3
    val fr2 = Output(Bool())     // Nominal flow signal 2
    val fr1 = Output(Bool())     // Nominal flow signal 1
    val dfr = Output(Bool())     // Supplemental flow signal
  })

  // Task 1: State Enumeration Definition
  object StateEnum {
    val BelowS1 = 0.U  // No sensors asserted
    val BetweenS2S1 = 1.U  // Only sensor 1 is asserted
    val BetweenS3S2 = 2.U  // Sensors 2 and 1 are asserted
    val AboveS3 = 3.U  // All sensors are asserted
  }
  import StateEnum._

  // Task 2: Current State Logic
  val currentState = WireDefault(BelowS1) // Default to BelowS1 state
  when(io.s(2)) { // s(3) maps to index 2 in a 3-bit vector
    currentState := AboveS3
  }.elsewhen(io.s(1)) {
    currentState := BetweenS3S2
  }.elsewhen(io.s(0)) {
    currentState := BetweenS2S1
  }

  // Task 3: State Registers and Reset
  val currentStateReg = RegInit(BelowS1)  // Current state register
  val previousStateReg = RegInit(BelowS1) // Previous state register
  when(reset.asBool) { // Synchronous reset
    currentStateReg := BelowS1
    previousStateReg := BelowS1
  }.otherwise {
    currentStateReg := currentState
    previousStateReg := currentStateReg
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  io.fr3 := (currentStateReg === BelowS1)
  io.fr2 := (currentStateReg === BelowS1) || (currentStateReg === BetweenS2S1)
  io.fr1 := (currentStateReg === BelowS1) || (currentStateReg === BetweenS2S1) || (currentStateReg === BetweenS3S2)

  // Task 5: Supplemental Flow Output (dfr)
  val isLevelRising = currentStateReg < previousStateReg // Enum ordering allows comparisons
  io.dfr := (currentStateReg === BelowS1) || isLevelRising

  // Task 6: Reset Validation (Integrated in above logic)
  // - All outputs will reset correctly via combination logic:
  //     * fr3, fr2, fr1 = 1 when currentStateReg is BelowS1.
  //     * dfr = 1 when currentStateReg is BelowS1.
}

// Generate the Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
