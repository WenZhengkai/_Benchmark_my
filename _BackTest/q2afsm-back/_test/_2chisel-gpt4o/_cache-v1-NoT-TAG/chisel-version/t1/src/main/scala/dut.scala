import chisel3._
import chisel3.util._

// Task 1: Define the state enumeration
object States extends ChiselEnum {
  val A, B, C, D = Value
}

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // Input r: 3 bits
    val g = Output(UInt(3.W)) // Output g: 3 bits
  })

  // Task 1: Define state register and initialize to A
  val stateReg = RegInit(States.A)

  // Task 6: Default output for g
  io.g := 0.U(3.W)

  // Task 7: State transition logic
  switch(stateReg) {
    is(States.A) {
      // Task 2: Transition logic for state A
      when(io.r(0) === 1.U) {
        stateReg := States.B
      }.elsewhen(io.r(1) === 1.U) {
        stateReg := States.C
      }.elsewhen(io.r(2) === 1.U) {
        stateReg := States.D
      }.otherwise {
        stateReg := States.A
      }
    }

    is(States.B) {
      // Task 3: Transition logic for state B
      when(io.r(0) === 1.U) {
        stateReg := States.B
      }.otherwise {
        stateReg := States.A
      }
    }

    is(States.C) {
      // Task 4: Transition logic for state C
      when(io.r(1) === 1.U) {
        stateReg := States.C
      }.otherwise {
        stateReg := States.A
      }
    }

    is(States.D) {
      // Task 5: Transition logic for state D
      when(io.r(2) === 1.U) {
        stateReg := States.D
      }.otherwise {
        stateReg := States.A
      }
    }
  }

  // Task 6: Output logic for g based on the current state
  io.g := MuxLookup(stateReg, 0.U, Array(
    States.B -> "b001".U, // g(0) = 1 when in state B
    States.C -> "b010".U, // g(1) = 1 when in state C
    States.D -> "b100".U  // g(2) = 1 when in state D
  ))
}

// Generate Verilog for the module (used for testing or synthesis)
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
