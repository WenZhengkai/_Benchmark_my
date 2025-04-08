import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))   // 3-bit water level sensor input
    val fr3 = Output(Bool())   // Nominal flow rate for level fr3
    val fr2 = Output(Bool())   // Nominal flow rate for level fr2
    val fr1 = Output(Bool())   // Nominal flow rate for level fr1
    val dfr = Output(Bool())   // Supplemental flow rate indicator
  })

  // States of the water level
  val level_low = 0.U(2.W)
  val level_mid_low = 1.U(2.W)
  val level_mid_high = 2.U(2.W)
  val level_high = 3.U(2.W)

  // Registers
  val state = RegInit(level_low) // Current state, reset defaults to low
  val prev_state = RegInit(level_low) // Tracks the state before the last change

  // Default output values
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // State Logic
  switch(state) {
    is(level_high) {
      // Water level is above the highest sensor (s3)
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := false.B
      io.dfr := false.B
      when(io.s === "b111".U) { // All sensors s[3], s[2], and s[1] are triggered
        state := level_high
      }.elsewhen(io.s === "b011".U) { // Drop to mid-high level
        prev_state := state
        state := level_mid_high
      }
    }
    is(level_mid_high) {
      // Water level is between s[3] and s[2]
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := true.B
      io.dfr := prev_state === level_mid_low // Open supplemental if previous was lower
      when(io.s === "b011".U) { // Sensors s[2] and s[1] are triggered
        state := level_mid_high
      }.elsewhen(io.s === "b001".U) { // Drop to mid-low level
        prev_state := state
        state := level_mid_low
      }.elsewhen(io.s === "b111".U) { // Rise to high level
        prev_state := state
        state := level_high
      }
    }
    is(level_mid_low) {
      // Water level is between s[2] and s[1]
      io.fr3 := false.B
      io.fr2 := true.B
      io.fr1 := true.B
      io.dfr := prev_state === level_low // Open supplemental if previous was lower
      when(io.s === "b001".U) { // Only sensor s[1] is triggered
        state := level_mid_low
      }.elsewhen(io.s === "b011".U) { // Rise to mid-high level
        prev_state := state
        state := level_mid_high
      }.elsewhen(io.s === "b000".U) { // Drop to low level
        prev_state := state
        state := level_low
      }
    }
    is(level_low) {
      // Water level is below the lowest sensor (s[1])
      io.fr3 := true.B
      io.fr2 := true.B
      io.fr1 := true.B
      io.dfr := true.B // Always high in this state because supplemental flow is needed
      when(io.s === "b000".U) { // No sensors are triggered
        state := level_low
      }.elsewhen(io.s === "b001".U) { // Rise to mid-low level
        prev_state := state
        state := level_mid_low
      }
    }
  }

  // Synchronous reset logic
  when(reset.asBool()) {
    state := level_low
    prev_state := level_low
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }
}

// Generate the Verilog Code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
