import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))    // 3-bit input for requests
    val g = Output(UInt(3.W))   // 3-bit output for grants
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  val stateReg = RegInit(State.A) // Initialize state register to state `A`

  // Default grant output
  io.g := 0.U // Default to 0, will be overridden based on state below

  // Task 7: Integrate All Logic with a Switch Statement
  switch(stateReg) {
    is(State.A) {
      // Task 2: Implement State Transition Logic for State `A`
      when(io.r(0) === 1.U) {
        stateReg := State.B
      }.elsewhen(io.r(1) === 1.U) {
        stateReg := State.C
      }.elsewhen(io.r(2) === 1.U) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.B) {
      // Task 3: Implement State Transition Logic for State `B`
      when(io.r(0) === 1.U) {
        stateReg := State.B
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.C) {
      // Task 4: Implement State Transition Logic for State `C`
      when(io.r(1) === 1.U) {
        stateReg := State.C
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.D) {
      // Task 5: Implement State Transition Logic for State `D`
      when(io.r(2) === 1.U) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }
  }

  // Task 6: Generate Output `g` Based on Current State
  io.g := 0.U                                  // Default: all grants are 0
  switch(stateReg) {
    is(State.B) {
      io.g := "b001".U                        // Grant for Device 0
    }
    is(State.C) {
      io.g := "b010".U                        // Grant for Device 1
    }
    is(State.D) {
      io.g := "b100".U                        // Grant for Device 2
    }
  }
}
