import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Input: 3-bit sensor readings
    val fr3 = Output(Bool()) // Output: Nominal flow signals
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool()) // Output: Supplemental flow signal
  })

  // Task 1: State Enumeration Definition
  object WaterLevel extends ChiselEnum {
    val BelowS1, BetweenS2S1, BetweenS3S2, AboveS3 = Value
  }

  import WaterLevel._ // Bring states into scope

  // Task 2: Current State Logic
  val currentState = WireDefault(BelowS1) // Default to the lowest state
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
  when(reset.asBool) {
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
  val isLevelRising = (currentStateReg < previousStateReg) // Using enum ordering
  io.dfr := (currentStateReg === BelowS1) || isLevelRising

  // Task 6: Integration and Reset Validation
  /* The design implicitly satisfies this step:
   * Upon reset:
   *   - `currentStateReg` and `previousStateReg` are set to `BelowS1`.
   *   - Outputs `fr3`, `fr2`, and `fr1` are computed based on `currentStateReg`.
   *   - Output `dfr` is set to true because `currentStateReg === BelowS1`.
   */
}

// Generate the Verilog for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
