import chisel3._
import chisel3.util._

/**
 * dut Module
 *
 * This module monitors the water level via three sensors (s[1] to s[3]) and controls the flow rate
 * using three nominal flow rate signals (fr1, fr2, fr3) and a supplemental flow valve control signal (dfr).
 */
class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))       // Sensor inputs s[1], s[2], and s[3]
    val reset = Input(Bool())      // Active-high synchronous reset
    val fr1 = Output(Bool())       // Flow rate control fr1
    val fr2 = Output(Bool())       // Flow rate control fr2
    val fr3 = Output(Bool())       // Flow rate control fr3
    val dfr = Output(Bool())       // Supplemental flow control
  })

  // Default output values
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Register to store the previous sensor state
  val prevLevel = RegInit(0.U(3.W))
  when(io.reset) {
    // Reset all state variables and outputs when reset is asserted
    prevLevel := 0.U
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  } .otherwise {
    // Update the previous level register each cycle
    prevLevel := io.s

    // Control logic
    when(io.s === "b111".U) { // Above s[3]: all sensors are asserted
      // No flow due to sufficient water level
      io.fr1 := false.B
      io.fr2 := false.B
      io.fr3 := false.B
      io.dfr := false.B
    } .elsewhen(io.s === "b011".U) { // Between s[3] and s[2]: s[1] and s[2] are asserted
      // Nominal flow rate fr1
      io.fr1 := true.B
      io.fr2 := false.B
      io.fr3 := false.B
      io.dfr := (prevLevel === "b001".U || prevLevel === "b000".U) // Supplemental flow if previously lower
    } .elsewhen(io.s === "b001".U) { // Between s[2] and s[1]: only s[1] is asserted
      // Nominal flow rates fr1 and fr2
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := false.B
      io.dfr := (prevLevel === "b000".U) // Supplemental flow if previously lower
    } .elsewhen(io.s === "b000".U) { // Below s[1]: no sensors are asserted
      // Maximum flow rate: all nominal and supplemental flows
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := true.B
      io.dfr := true.B
    }
  }
}

// Generate Verilog for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
