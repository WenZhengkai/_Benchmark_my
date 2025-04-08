import chisel3._
import chisel3.util._

// Chisel Enum for defining the FSM states
object Q2AStates extends ChiselEnum {
  val A, B, C, D = Value
}

// FSM module
class dut extends Module {
  // I/O declarations
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input
    val g = Output(UInt(3.W)) // 3-bit output
  })

  // State register with an initial state of `A`
  val state = RegInit(Q2AStates.A)

  // Output initialization
  io.g := 0.U // By default, all outputs are set to 0

  // State transition and output logic
  switch(state) {
    is(Q2AStates.A) {
      // Priority state transitions based on `r`
      when(io.r(0)) {
        state := Q2AStates.B
      }.elsewhen(io.r(1)) {
        state := Q2AStates.C
      }.elsewhen(io.r(2)) {
        state := Q2AStates.D
      }.otherwise {
        state := Q2AStates.A
      }

      // In state A, the output remains 0 (default already handled)
    }

    is(Q2AStates.B) {
      // Grant access to device 0
      io.g := "b001".U // Set g(0) to 1

      // State transitions
      when(io.r(0)) {
        state := Q2AStates.B // Stay in B as long as r(0) == 1
      }.otherwise {
        state := Q2AStates.A // Go back to A if r(0) == 0
      }
    }

    is(Q2AStates.C) {
      // Grant access to device 1
      io.g := "b010".U // Set g(1) to 1

      // State transitions
      when(io.r(1)) {
        state := Q2AStates.C // Stay in C as long as r(1) == 1
      }.otherwise {
        state := Q2AStates.A // Go back to A if r(1) == 0
      }
    }

    is(Q2AStates.D) {
      // Grant access to device 2
      io.g := "b100".U // Set g(2) to 1

      // State transitions
      when(io.r(2)) {
        state := Q2AStates.D // Stay in D as long as r(2) == 1
      }.otherwise {
        state := Q2AStates.A // Go back to A if r(2) == 0
      }
    }
  }

  // Synchronous reset logic (already handled by `RegInit`)
}

// Generate the Verilog for the design (if you are generating the hardware file)
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
