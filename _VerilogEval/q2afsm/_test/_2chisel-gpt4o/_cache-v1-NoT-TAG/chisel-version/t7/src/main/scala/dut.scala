import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))    // 3-bit input for requests
    val g = Output(UInt(3.W))   // 3-bit output for grants
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value // Define states: A, B, C, D
  }

  val stateReg = RegInit(State.A) // State register initialized to A
   
  // Default output (Task 6)
  io.g := 0.U

  // Task 7: Integrate All Logic with Switch Statement
  switch(stateReg) {
    is(State.A) { // Task 2: Implement State Transition Logic for State A
      when(io.r(0)) {
        stateReg := State.B
      }.elsewhen(io.r(1)) {
        stateReg := State.C
      }.elsewhen(io.r(2)) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.B) { // Task 3: Implement State Transition Logic for State B
      when(io.r(0)) {
        stateReg := State.B
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.C) { // Task 4: Implement State Transition Logic for State C
      when(io.r(1)) {
        stateReg := State.C
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.D) { // Task 5: Implement State Transition Logic for State D
      when(io.r(2)) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }
  }

  // Task 6: Generate Output `g` Based on Current State
  io.g := Mux(stateReg === State.B, "b001".U,
           Mux(stateReg === State.C, "b010".U,
           Mux(stateReg === State.D, "b100".U,
           "b000".U)))
}

// Generate the Verilog file (for simulation and synthesis)
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
