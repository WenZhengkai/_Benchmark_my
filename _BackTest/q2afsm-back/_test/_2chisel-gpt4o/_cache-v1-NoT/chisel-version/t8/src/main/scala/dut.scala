import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

// Specification: FSM to arbitrate access between three requesting devices.
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Step 1: Define the states using ChiselEnum
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  // Step 2: State register to hold the current state
  val state = RegInit(State.A) // Initialize to state A

  // Step 3 to Step 6: Default output and state transition logic
  io.g := 0.U // Default all grant outputs to 0

  // Define the FSM state transitions and outputs
  switch(state) {
    is(State.A) {
      // Priority logic for transitions in state A
      when(io.r(0)) {
        state := State.B
      }.elsewhen(io.r(1)) {
        state := State.C
      }.elsewhen(io.r(2)) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }

    is(State.B) {
      // In state B, grant to device 0
      io.g := "b001".U // g(0) = 1
      // Remain in B if r(0) is 1, otherwise transition back to A
      when(io.r(0)) {
        state := State.B
      }.otherwise {
        state := State.A
      }
    }

    is(State.C) {
      // In state C, grant to device 1
      io.g := "b010".U // g(1) = 1
      // Remain in C if r(1) is 1, otherwise transition back to A
      when(io.r(1)) {
        state := State.C
      }.otherwise {
        state := State.A
      }
    }

    is(State.D) {
      // In state D, grant to device 2
      io.g := "b001".U // g(2) = 1
      // Remain in D if r(2) is 1, otherwise transition back to A
      when(io.r(2)) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }
  }

  // Step 7: Synchronous reset logic
  when(reset.asBool) {
    state := State.A // Force state to A on reset
  }
}

// Generate the Verilog code for the FSM
/*
object dutMake extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
