import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // Request signals (3 bits for r0, r1, r2)
    val g = Output(UInt(3.W)) // Grant signals (3 bits for g0, g1, g2)
  })

  // Task 1: Define the state enumeration and state register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  val stateReg = RegInit(State.A) // Initialize stateReg to A

  // Default grant outputs to 0
  io.g := 0.U

  // Task 7: Implement the finite state machine (FSM)
  switch(stateReg) {
    // Task 2: State A logic (Priority request handling: r0 > r1 > r2)
    is(State.A) {
      when(io.r(0)) { // Check if r(0) is asserted
        stateReg := State.B
      }.elsewhen(io.r(1)) { // Check if r(1) is asserted
        stateReg := State.C
      }.elsewhen(io.r(2)) { // Check if r(2) is asserted
        stateReg := State.D
      }.otherwise {
        stateReg := State.A // Stay in A if no requests
      }
    }

    // Task 3: State B logic (Grant persistence for r0)
    is(State.B) {
      when(io.r(0)) {
        stateReg := State.B // Stay in B if r(0) is asserted
      }.otherwise {
        stateReg := State.A // Go back to A if r(0) is deasserted
      }
    }

    // Task 4: State C logic (Grant persistence for r1)
    is(State.C) {
      when(io.r(1)) {
        stateReg := State.C // Stay in C if r(1) is asserted
      }.otherwise {
        stateReg := State.A // Go back to A if r(1) is deasserted
      }
    }

    // Task 5: State D logic (Grant persistence for r2)
    is(State.D) {
      when(io.r(2)) {
        stateReg := State.D // Stay in D if r(2) is asserted
      }.otherwise {
        stateReg := State.A // Go back to A if r(2) is deasserted
      }
    }
  }

  // Task 6: Output logic
  io.g := MuxLookup(stateReg, 0.U, Seq(
    State.B -> "b001".U, // Grant g0 in state B
    State.C -> "b010".U, // Grant g1 in state C
    State.D -> "b100".U  // Grant g2 in state D
  ))
}

// Generate the Verilog code for the design
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
