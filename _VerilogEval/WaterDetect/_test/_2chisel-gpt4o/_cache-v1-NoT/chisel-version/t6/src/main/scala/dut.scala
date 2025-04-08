import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3-bit input for water level sensors
    val fr3 = Output(Bool()) // Output for flow rate #3
    val fr2 = Output(Bool()) // Output for flow rate #2
    val fr1 = Output(Bool()) // Output for flow rate #1
    val dfr = Output(Bool()) // Output for supplemental flow valve
  })

  // Define registers to hold outputs and previous sensor state
  val fr3 = RegInit(false.B) // Flow rate #3
  val fr2 = RegInit(false.B) // Flow rate #2
  val fr1 = RegInit(false.B) // Flow rate #1
  val dfr = RegInit(false.B) // Supplemental flow valve
  val prev_s = RegInit(0.U(3.W)) // Register to hold the previous sensor state

  // Assign the register values to outputs
  io.fr3 := fr3
  io.fr2 := fr2
  io.fr1 := fr1
  io.dfr := dfr

  // Main logic for water level detection and control
  when(reset.asBool) {
    // Synchronous reset: Set all outputs to 1 and registers to safe default
    fr3 := true.B
    fr2 := true.B
    fr1 := true.B
    dfr := true.B
    prev_s := 0.U
  }.otherwise {
    // Task 2: Update the state of the system based on water level sensors
    // Update flow rate control based on current sensor readings
    when(io.s(2)) { // When `s[3]` is high (above top sensor)
      fr3 := false.B
      fr2 := false.B
      fr1 := false.B
    }.elsewhen(io.s(1)) { // When between `s[3]` and `s[2]`
      fr3 := false.B
      fr2 := false.B
      fr1 := true.B
    }.elsewhen(io.s(0)) { // When between `s[2]` and `s[1]`
      fr3 := false.B
      fr2 := true.B
      fr1 := true.B
    }.otherwise { // When below `s[1]`
      fr3 := true.B
      fr2 := true.B
      fr1 := true.B
    }

    // Task 4: Update supplemental flow valve (`dfr`)
    // Compare current sensor readings with previous to detect water level change
    dfr := io.s > prev_s // Active `1` if level is higher; otherwise, `0`

    // Update previous sensor state
    prev_s := io.s
  }
}

// Generate the Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
