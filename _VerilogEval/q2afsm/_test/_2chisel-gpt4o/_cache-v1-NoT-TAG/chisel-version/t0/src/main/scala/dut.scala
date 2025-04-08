import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  val stateReg = RegInit(State.A)

  // Default output
  io.g := 0.U

  // Task 7: Main state transition and output logic
  switch(stateReg) {
    // Task 2: State A - Priority-based transitions
    is(State.A) {
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

    // Task 3: State B - Grant persistence for Device 0
    is(State.B) {
      when(io.r(0) === 1.U) {
        stateReg := State.B
      }.otherwise {
        stateReg := State.A
      }
    }

    // Task 4: State C - Grant persistence for Device 1
    is(State.C) {
      when(io.r(1) === 1.U) {
        stateReg := State.C
      }.otherwise {
        stateReg := State.A
      }
    }

    // Task 5: State D - Grant persistence for Device 2
    is(State.D) {
      when(io.r(2) === 1.U) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }
  }

  // Task 6: Generate output g based on current state
  io.g := MuxLookup(stateReg, 0.U, Seq(
    State.B -> "b001".U, // g(0) = 1, g(1) = 0, g(2) = 0
    State.C -> "b010".U, // g(0) = 0, g(1) = 1, g(2) = 0
    State.D -> "b100".U  // g(0) = 0, g(1) = 0, g(2) = 1
  ))
}

// Generate the Verilog for the dut module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
