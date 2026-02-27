import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // Request input signals
    val g = Output(UInt(3.W)) // Grant output signals
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  val stateReg = RegInit(State.A)

  // Default output for grant signals
  io.g := 0.U

  // Task 7: Switch Statement to Handle All Logic
  switch(stateReg) {
    // Task 2: Implement State Transition Logic for State A
    is(State.A) {
      when(io.r(0)) {              // Check r(0) first
        stateReg := State.B
      } .elsewhen(io.r(1)) {       // Check r(1) if r(0) is not set
        stateReg := State.C
      } .elsewhen(io.r(2)) {       // Check r(2) if r(0) and r(1) are not set
        stateReg := State.D
      } .otherwise {
        stateReg := State.A        // Stay in state A
      }
    }

    // Task 3: Implement State Transition Logic for State B
    is(State.B) {
      when(io.r(0)) {              // Stay in B if r(0) is still active
        stateReg := State.B
      } .otherwise {               // Transition back to A otherwise
        stateReg := State.A
      }
    }

    // Task 4: Implement State Transition Logic for State C
    is(State.C) {
      when(io.r(1)) {              // Stay in C if r(1) is still active
        stateReg := State.C
      } .otherwise {               // Transition back to A otherwise
        stateReg := State.A
      }
    }

    // Task 5: Implement State Transition Logic for State D
    is(State.D) {
      when(io.r(2)) {              // Stay in D if r(2) is still active
        stateReg := State.D
      } .otherwise {               // Transition back to A otherwise
        stateReg := State.A
      }
    }
  }

  // Task 6: Generate Output g Based on Current State
  io.g := MuxLookup(stateReg.asUInt, 0.U, Seq(
    State.B.asUInt -> "b001".U,   // Grant signal for Device 0
    State.C.asUInt -> "b010".U,   // Grant signal for Device 1
    State.D.asUInt -> "b100".U    // Grant signal for Device 2
  ))
}

// Generate the Verilog for the dut module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
