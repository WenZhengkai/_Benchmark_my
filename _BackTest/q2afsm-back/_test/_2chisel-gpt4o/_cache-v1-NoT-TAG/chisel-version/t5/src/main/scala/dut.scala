import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // Input request signals (r2, r1, r0)
    val g = Output(UInt(3.W)) // Output grant signals (g2, g1, g0)
  })

  // Task 1: Define State Enumeration and Register
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  
  val stateReg = RegInit(State.A)

  // Task 6: Default Output Logic
  io.g := 0.U // Default g to 0 in state A

  // Task 7: Implement State Transition Logic with Combined Outputs
  switch(stateReg) {
    is(State.A) {
      // Task 2: State A Transition Logic
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

    is(State.B) {
      // Task 3: State B Transition Logic
      when(io.r(0)) {
        stateReg := State.B
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.C) {
      // Task 4: State C Transition Logic
      when(io.r(1)) {
        stateReg := State.C
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.D) {
      // Task 5: State D Transition Logic
      when(io.r(2)) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }
  }

  // Task 6: Assign Outputs Based on Current State
  io.g := MuxLookup(stateReg.asUInt, 0.U(3.W), Seq(
    State.B.asUInt -> "b001".U, // Grant for Device 0
    State.C.asUInt -> "b010".U, // Grant for Device 1
    State.D.asUInt -> "b100".U  // Grant for Device 2
  ))
}

// Generate the Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
