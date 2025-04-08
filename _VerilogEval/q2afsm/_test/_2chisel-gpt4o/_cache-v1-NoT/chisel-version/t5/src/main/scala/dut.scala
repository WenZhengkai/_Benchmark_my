import chisel3._
import chisel3.util._

/** Chisel module for the dut */
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Define the FSM states as a ChiselEnum
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  // State register to hold the current FSM state
  val state = RegInit(State.A)

  // Default output, no grants
  io.g := 0.U

  // State transition and output logic
  switch(state) {
    is(State.A) { // State A
      when(io.r(0)) {
        state := State.B // Priority 1: Transition to B if r(0) is high
      }.elsewhen(io.r(1)) {
        state := State.C // Priority 2: Transition to C if r(1) is high
      }.elsewhen(io.r(2)) {
        state := State.D // Priority 3: Transition to D if r(2) is high
      }.otherwise {
        state := State.A // Stay in A
      }
    }

    is(State.B) { // State B
      io.g := "b001".U // Grant to device 0
      when(io.r(0)) {
        state := State.B // Stay in B as long as r(0) is high
      }.otherwise {
        state := State.A // Otherwise, transition back to A
      }
    }

    is(State.C) { // State C
      io.g := "b010".U // Grant to device 1
      when(io.r(1)) {
        state := State.C // Stay in C as long as r(1) is high
      }.otherwise {
        state := State.A // Otherwise, transition back to A
      }
    }

    is(State.D) { // State D
      io.g := "b100".U // Grant to device 2
      when(io.r(2)) {
        state := State.D // Stay in D as long as r(2) is high
      }.otherwise {
        state := State.A // Otherwise, transition back to A
      }
    }
  }
}

// Generate the Verilog code for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
