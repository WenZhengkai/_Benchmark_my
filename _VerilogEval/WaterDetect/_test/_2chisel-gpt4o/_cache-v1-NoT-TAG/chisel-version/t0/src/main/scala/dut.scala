import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3-bit input signal from sensors
    val fr3 = Output(Bool())  // Nominal flow output 3
    val fr2 = Output(Bool())  // Nominal flow output 2
    val fr1 = Output(Bool())  // Nominal flow output 1
    val dfr = Output(Bool())  // Supplemental flow output
  })

  // Task 1: State Enumeration Definition
  val (BelowS1 :: BetweenS2S1 :: BetweenS3S2 :: AboveS3 :: Nil) = Enum(4)

  // Task 2: Current State Logic
  val currentState = WireDefault(BelowS1) // Default to lowest state
  when(io.s(2)) {
    currentState := AboveS3
  }.elsewhen(io.s(1)) {
    currentState := BetweenS3S2
  }.elsewhen(io.s(0)) {
    currentState := BetweenS2S1
  }

  // Task 3: State Registers and Reset
  val currentStateReg = RegInit(BelowS1)
  val previousStateReg = RegInit(BelowS1)

  when(reset.asBool) { // Active-high reset
    currentStateReg := BelowS1
    previousStateReg := BelowS1
  }.otherwise {
    previousStateReg := currentStateReg
    currentStateReg := currentState
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  io.fr3 := (currentStateReg === BelowS1)
  io.fr2 := (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)
  io.fr1 := (currentStateReg === BetweenS3S2) || (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)

  // Task 5: Supplemental Flow Output (dfr)
  val isLevelRising = currentStateReg < previousStateReg // Enum ordering allows comparisons
  io.dfr := (currentStateReg === BelowS1) || isLevelRising

  // Task 6: Reset Validation occurs automatically via initial state setup
}
