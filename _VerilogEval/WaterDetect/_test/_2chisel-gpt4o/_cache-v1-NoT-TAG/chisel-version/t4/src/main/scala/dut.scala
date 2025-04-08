import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // --- Task 1: State Enumeration Definition ---
  // Define the states with ordered enumeration
  object WaterState extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value
  }
  import WaterState._

  // --- Task 2: Current State Logic ---
  // Determine current state based on sensor inputs
  val currentState = WireDefault(BelowS1) // Default to lowest state
  when(io.s(2)) { // Check most significant sensor s[3]
    currentState := AboveS3
  }.elsewhen(io.s(1)) { // Check second sensor s[2]
    currentState := BetweenS3S2
  }.elsewhen(io.s(0)) { // Check least significant sensor s[1]
    currentState := BetweenS2S1
  }

  // --- Task 3: State Registers and Reset ---
  // Track current and previous states with synchronous reset
  val currentStateReg = RegInit(BelowS1)
  val previousStateReg = RegInit(BelowS1)

  when(reset.asBool) { // Active-high reset
    currentStateReg := BelowS1
    previousStateReg := BelowS1
  }.otherwise {
    previousStateReg := currentStateReg
    currentStateReg := currentState
  }

  // --- Task 4: Nominal Flow Outputs (fr3, fr2, fr1) ---
  // Set outputs based on current state
  io.fr3 := (currentStateReg === BelowS1)
  io.fr2 := (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)
  io.fr1 := (currentStateReg === BetweenS3S2) || (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)

  // --- Task 5: Supplemental Flow Output (dfr) ---
  // Compute dfr based on state transitions and current level
  val isLevelRising = currentStateReg < previousStateReg // Use Enum ordering for comparisons
  io.dfr := (currentStateReg === BelowS1) || isLevelRising

  // --- Task 6: Integration and Reset Validation ---
  // By default, reset logic ensures:
  // - currentStateReg and previousStateReg reset to BelowS1
  // - Outputs are set to their corresponding default: fr3, fr2, fr1 = true; dfr = true
}

// This is needed to generate the Verilog code when running Chisel Generator
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
