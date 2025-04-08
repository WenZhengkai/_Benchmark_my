import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s       = Input(UInt(3.W)) // Sensor inputs as a 3-bit vector
    val fr3     = Output(Bool())   // Flow regulator output 3
    val fr2     = Output(Bool())   // Flow regulator output 2
    val fr1     = Output(Bool())   // Flow regulator output 1
    val dfr     = Output(Bool())   // Supplemental flow output
  })

  // Task 1: State Enumeration Definition
  object WaterLevel extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value
  }
  import WaterLevel._

  // Task 2: Current State Logic
  val currentState = WireDefault(WaterLevel.BelowS1) // Default state

  when(io.s(2)) { 
    currentState := WaterLevel.AboveS3 
  }.elsewhen(io.s(1)) { 
    currentState := WaterLevel.BetweenS3S2 
  }.elsewhen(io.s(0)) { 
    currentState := WaterLevel.BetweenS2S1 
  }

  // Task 3: State Registers and Reset
  val currentStateReg = RegInit(WaterLevel.BelowS1) // Register for current state
  val previousStateReg = RegInit(WaterLevel.BelowS1) // Register for previous state

  // Update state registers
  when(reset.asBool) {
    currentStateReg := WaterLevel.BelowS1
    previousStateReg := WaterLevel.BelowS1
  }.otherwise {
    previousStateReg := currentStateReg
    currentStateReg := currentState
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  io.fr3 := currentStateReg === WaterLevel.BelowS1
  io.fr2 := (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)
  io.fr1 := (currentStateReg === WaterLevel.BetweenS3S2) || (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)

  // Task 5: Supplemental Flow Output (dfr)
  val isLevelRising = currentStateReg < previousStateReg // Using automatic enum ordering
  io.dfr := (currentStateReg === WaterLevel.BelowS1) || isLevelRising

  // Task 6: Integration and Reset Validation
  // Reset logic ensures that outputs are initialized to correct values as per design:
  // All outputs default correctly since `reset` initializes `currentStateReg` and `previousStateReg` to `BelowS1`,
  // and combinational logic ensures outputs behave as expected.
}

// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
