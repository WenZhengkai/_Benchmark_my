import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow rate 3
    val fr2 = Output(Bool()) // Nominal flow rate 2
    val fr1 = Output(Bool()) // Nominal flow rate 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Synchronous reset
  })

  // Define states for the water level
  val state = RegInit(0.U(2.W)) // 2-bit state register
  val prevState = RegInit(0.U(2.W)) // Previous state

  // State encoding
  val STATE_ABOVE_S3 = 0.U // Above s[3]
  val STATE_BETWEEN_S3_S2 = 1.U // Between s[3] and s[2]
  val STATE_BETWEEN_S2_S1 = 2.U // Between s[2] and s[1]
  val STATE_BELOW_S1 = 3.U // Below s[1]

  // Synchronous reset logic
  when(io.reset) {
    state := STATE_BELOW_S1
    prevState := STATE_BELOW_S1
  }.otherwise {
    // Update previous state
    prevState := state

    // Determine current state based on sensors
    when(io.s(2) && io.s(1) && io.s(0)) {
      state := STATE_ABOVE_S3
    }.elsewhen(io.s(1) && io.s(0)) {
      state := STATE_BETWEEN_S3_S2
    }.elsewhen(io.s(0)) {
      state := STATE_BETWEEN_S2_S1
    }.otherwise {
      state := STATE_BELOW_S1
    }
  }

  // Output logic
  io.fr3 := state === STATE_BELOW_S1
  io.fr2 := state === STATE_BETWEEN_S2_S1 || state === STATE_BELOW_S1
  io.fr1 := state === STATE_BETWEEN_S3_S2 || state === STATE_BETWEEN_S2_S1 || state === STATE_BELOW_S1
  io.dfr := prevState < state // Open supplemental valve if previous state was lower
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
