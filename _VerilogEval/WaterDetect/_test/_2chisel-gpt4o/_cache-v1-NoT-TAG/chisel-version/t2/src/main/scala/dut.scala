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

  // Task 1: State Enumeration Definition
  // Define enumeration for water level states
  object WaterLevel extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value
  }

  import WaterLevel._ // Import enum state names for convenience

  // Task 2: Current State Logic
  // Decode current state from sensor inputs
  val currentState = WireDefault(BelowS1)
  when(io.s(2)) {
    currentState := AboveS3 // Highest sensor active
  }.elsewhen(io.s(1)) {
    currentState := BetweenS3S2 // Middle sensor active
  }.elsewhen(io.s(0)) {
    currentState := BetweenS2S1 // Lowest sensor active
  }

  // Task 3: State Registers and Reset
  // Registers to hold the current and previous states
  val currentStateReg = RegInit(BelowS1)
  val previousStateReg = RegInit(BelowS1)

  // Update currentStateReg and previousStateReg on every clock cycle
  when(reset.asBool) { // Active-high reset
    currentStateReg := BelowS1
    previousStateReg := BelowS1
  }.otherwise {
    previousStateReg := currentStateReg
    currentStateReg := currentState
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  // Set outputs based on the current state
  io.fr3 := (currentStateReg === BelowS1)
  io.fr2 := (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)
  io.fr1 := (currentStateReg === BetweenS3S2) || (currentStateReg === BetweenS2S1) || (currentStateReg === BelowS1)

  // Task 5: Supplemental Flow Output (dfr)
  // Determine if the water level is rising
  val isLevelRising = currentStateReg < previousStateReg // Enum ordering comparison
  io.dfr := (currentStateReg === BelowS1) || isLevelRising

  // Task 6: Integration and Reset Validation
  // Reset ensures default state outputs:
  // - currentStateReg and previousStateReg reset to BelowS1 (via RegInit in Task 3)
  // - fr3, fr2, and fr1 default to true when currentStateReg === BelowS1
  // - dfr is forced to true when currentStateReg === BelowS1
}

// Generate the Verilog for the dut module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
