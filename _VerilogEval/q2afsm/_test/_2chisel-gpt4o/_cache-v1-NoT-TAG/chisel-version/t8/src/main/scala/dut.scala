import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit request input
    val g = Output(UInt(3.W)) // 3-bit grant output
  })

  // Task 1: Define State Enumeration and Register  
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  val stateReg = RegInit(State.A)

  // Task 6: Default Output `g`
  io.g := 0.U // Default all grants to 0 unless specified otherwise

  // Task 7: Integrate All Logic with a Switch Statement
  switch(stateReg) {
    is(State.A) {
      // Task 2: State Transition Logic for `A`
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
      // Task 3: State Transition Logic for `B`
      when(io.r(0)) {
        stateReg := State.B
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.C) {
      // Task 4: State Transition Logic for `C`
      when(io.r(1)) {
        stateReg := State.C
      }.otherwise {
        stateReg := State.A
      }
    }

    is(State.D) {
      // Task 5: State Transition Logic for `D`
      when(io.r(2)) {
        stateReg := State.D
      }.otherwise {
        stateReg := State.A
      }
    }
  }

  // Task 6: Generate Output `g` Based on Current State
  io.g := MuxLookup(stateReg.asUInt, 0.U, Array(
    State.B.asUInt -> "b001".U, // Grant Device 0 in State `B`
    State.C.asUInt -> "b010".U, // Grant Device 1 in State `C`
    State.D.asUInt -> "b100".U  // Grant Device 2 in State `D`
  ))
}