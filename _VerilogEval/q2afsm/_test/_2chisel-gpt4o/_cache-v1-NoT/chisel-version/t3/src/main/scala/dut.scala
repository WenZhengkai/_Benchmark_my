import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input request signal
    val g = Output(UInt(3.W)) // 3-bit output grant signal
  })

  // Define the FSM states using ChiselEnum
  object State extends ChiselEnum {
    val A, B, C, D = Value // States A, B, C, D
  }

  // Create a state register initialized to state A
  val state = RegInit(State.A)

  // Default grant outputs
  io.g := 0.U

  // State transition and output logic
  switch(state) {
    is(State.A) {
      // Priority-based state transition logic from state A
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
      // Output logic for state B
      io.g := "b001".U // Grant access to device 0

      // Transition logic for state B
      when(io.r(0)) {
        state := State.B // Stay in state B if r(0) remains asserted
      }.otherwise {
        state := State.A // Transition back to state A otherwise
      }
    }

    is(State.C) {
      // Output logic for state C
      io.g := "b010".U // Grant access to device 1

      // Transition logic for state C
      when(io.r(1)) {
        state := State.C // Stay in state C if r(1) remains asserted
      }.otherwise {
        state := State.A // Transition back to state A otherwise
      }
    }

    is(State.D) {
      // Output logic for state D
      io.g := "b010".U // Grant access to device 2

      // Transition logic for state D
      when(io.r(2)) {
        state := State.D // Stay in state D if r(2) remains asserted
      }.otherwise {
        state := State.A // Transition back to state A otherwise
      }
    }
  }
}

// Generate the Verilog to test the FSM
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
