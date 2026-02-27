import chisel3._
import chisel3.util._

// Define dut as a Chisel module
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // Input requests from 3 devices
    val g = Output(UInt(3.W)) // Output grants to 3 devices
  })

  // Task 1: Define the FSM states using ChiselEnum
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  // Register to hold current state, initialized to state A
  val currentState = RegInit(State.A)

  // Output grant signals, default to 0
  io.g := 0.U

  // Synchronous reset logic and FSM state transition/output logic
  switch(currentState) {
    is(State.A) { // State A
      when(io.r(0)) { // Transition to state B if r(0) == 1
        currentState := State.B
      }.elsewhen(io.r(1)) { // Transition to state C if r(1) == 1
        currentState := State.C
      }.elsewhen(io.r(2)) { // Transition to state D if r(2) == 1
        currentState := State.D
      }.otherwise { // Stay in state A
        currentState := State.A
      }
    }
    is(State.B) { // State B
      io.g := "b001".U // Grant to device 0
      when(io.r(0)) { // Stay in state B if r(0) == 1
        currentState := State.B
      }.otherwise { // Otherwise transition to state A
        currentState := State.A
      }
    }
    is(State.C) { // State C
      io.g := "b010".U // Grant to device 1
      when(io.r(1)) { // Stay in state C if r(1) == 1
        currentState := State.C
      }.otherwise { // Otherwise transition to state A
        currentState := State.A
      }
    }
    is(State.D) { // State D
      io.g := "b100".U // Grant to device 2
      when(io.r(2)) { // Stay in state D if r(2) == 1
        currentState := State.D
      }.otherwise { // Otherwise transition to state A
        currentState := State.A
      }
    }
  }
}

// Generate the Verilog code for the FSM
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
