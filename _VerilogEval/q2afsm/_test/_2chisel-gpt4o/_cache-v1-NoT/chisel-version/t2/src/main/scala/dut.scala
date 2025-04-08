import chisel3._
import chisel3.util._

// Define the FSM's states using ChiselEnum
object State extends ChiselEnum {
  val A, B, C, D = Value
}

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input `r`
    val g = Output(UInt(3.W)) // 3-bit output `g`
  })

  // Initial state of the FSM
  val state = RegInit(State.A)

  // Default output signal values
  io.g := 0.U

  // State transition logic and output logic
  switch(state) {
    is(State.A) {
      // Transition logic for state A
      when(io.r(0) === 1.B) { state := State.B }
      .elsewhen(io.r(1) === 1.B) { state := State.C }
      .elsewhen(io.r(2) === 1.B) { state := State.D }
      .otherwise { state := State.A } // Stay in state A
    }

    is(State.B) {
      // Set g(0) to 1 in state B
      io.g := "b001".U
      // Transition logic for state B
      when(io.r(0) === 1.B) { state := State.B } // Stay in state B
      .otherwise { state := State.A } // Transition back to state A
    }

    is(State.C) {
      // Set g(1) to 1 in state C
      io.g := "b010".U
      // Transition logic for state C
      when(io.r(1) === 1.B) { state := State.C } // Stay in state C
      .otherwise { state := State.A } // Transition back to state A
    }

    is(State.D) {
      // Set g(2) to 1 in state D
      io.g := "b100".U
      // Transition logic for state D
      when(io.r(2) === 1.B) { state := State.D } // Stay in state D
      .otherwise { state := State.A } // Transition back to state A
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
