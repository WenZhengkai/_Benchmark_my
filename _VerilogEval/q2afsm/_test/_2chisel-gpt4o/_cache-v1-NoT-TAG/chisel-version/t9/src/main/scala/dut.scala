import chisel3._
import chisel3.util._

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input requests
    val g = Output(UInt(3.W)) // 3-bit output grants
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  val stateReg = RegInit(State.A)

  // Default grant output
  io.g := 0.U

  // Task 7: Integrate all logic with a Switch Statement
  switch(stateReg) {
    // Task 2: State Transition Logic for State A
    is(State.A) {
      when(io.r(0)) {
        stateReg := State.B // Priority to r(0)
      }.elsewhen(io.r(1)) {
        stateReg := State.C // Priority to r(1) if r(0) is 0
      }.elsewhen(io.r(2)) {
        stateReg := State.D // Priority to r(2) if r(0) and r(1) are 0
      }.otherwise {
        stateReg := State.A // Stay in A if no requests
      }
    }

    // Task 3: State Transition Logic for State B
    is(State.B) {
      when(io.r(0)) {
        stateReg := State.B // Stay in B if r(0) is still 1
      }.otherwise {
        stateReg := State.A // Go back to A if r(0) becomes 0
      }
    }

    // Task 4: State Transition Logic for State C
    is(State.C) {
      when(io.r(1)) {
        stateReg := State.C // Stay in C if r(1) is still 1
      }.otherwise {
        stateReg := State.A // Go back to A if r(1) becomes 0
      }
    }

    // Task 5: State Transition Logic for State D
    is(State.D) {
      when(io.r(2)) {
        stateReg := State.D // Stay in D if r(2) is still 1
      }.otherwise {
        stateReg := State.A // Go back to A if r(2) becomes 0
      }
    }
  }

  // Task 6: Generate Output `g` Based on Current State
  io.g := 0.U // Default value for g
  switch(stateReg) {
    is(State.B) { io.g := "b001".U } // g0 asserted
    is(State.C) { io.g := "b010".U } // g1 asserted
    is(State.D) { io.g := "b100".U } // g2 asserted
  }
}

// Companion object for generating Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
