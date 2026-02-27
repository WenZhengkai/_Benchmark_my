import chisel3._
import chisel3.util._

// Define the FSM as a Chisel Module
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for request signals
    val g = Output(UInt(3.W)) // 3-bit output for grant signals
  })

  // Step 1: Define the state enumeration
  object State extends ChiselEnum {
    val A, B, C, D = Value // States A, B, C, and D
  }

  // Define a register to hold the current state with synchronous reset
  val state = RegInit(State.A)

  // By default, set the outputs to 0
  io.g := 0.U

  // Step 2: Define the state transition logic and output logic
  switch(state) {
    is(State.A) {
      // Transition out of state A based on priority and request signals
      when(io.r(0)) {
        state := State.B
      } .elsewhen(io.r(1)) {
        state := State.C
      } .elsewhen(io.r(2)) {
        state := State.D
      } .otherwise {
        state := State.A // Stay in state A if no request
      }
    }

    is(State.B) {
      // Grant access to device 0
      io.g := "b001".U
      // Stay in state B as long as r(0) is 1
      when(io.r(0)) {
        state := State.B
      } .otherwise {
        state := State.A
      }
    }

    is(State.C) {
      // Grant access to device 1
      io.g := "b010".U
      // Stay in state C as long as r(1) is 1
      when(io.r(1)) {
        state := State.C
      } .otherwise {
        state := State.A
      }
    }

    is(State.D) {
      // Grant access to device 2
      io.g := "b100".U
      // Stay in state D as long as r(2) is 1
      when(io.r(2)) {
        state := State.D
      } .otherwise {
        state := State.A
      }
    }
  }
}

// Generate the Verilog for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
