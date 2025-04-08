import chisel3._
import chisel3.util._

// Define the FSM States using ChiselEnum
object Q2AStates extends ChiselEnum {
  val A, B, C, D = Value // States A, B, C, D
}

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Task 1: Define State Register with Initial State A
  import Q2AStates._ // Import the ChiselEnum for states
  val stateReg = RegInit(A) // State register initialized to state A

  // Default output (set to zero)
  io.g := 0.U

  // FSM Logic - State Transitions and Output Logic
  switch(stateReg) {
    is(A) { // Task 2: Handle Transitions in State A
      when(io.r(0) === 1.U) {
        stateReg := B
      }.elsewhen(io.r(1) === 1.U) {
        stateReg := C
      }.elsewhen(io.r(2) === 1.U) {
        stateReg := D
      }.otherwise {
        stateReg := A // Stay in state A
      }
    }
    is(B) { // Task 3: Handle Transitions in State B
      when(io.r(0) === 1.U) {
        stateReg := B // Stay in B if r0 is still asserted
      }.otherwise {
        stateReg := A // Return to A if r0 is deasserted
      }
      io.g := "b001".U // Grant Device 0 (g0)
    }
    is(C) { // Task 4: Handle Transitions in State C
      when(io.r(1) === 1.U) {
        stateReg := C // Stay in C if r1 is still asserted
      }.otherwise {
        stateReg := A // Return to A if r1 is deasserted
      }
      io.g := "b010".U // Grant Device 1 (g1)
    }
    is(D) { // Task 5: Handle Transitions in State D
      when(io.r(2) === 1.U) {
        stateReg := D // Stay in D if r2 is still asserted
      }.otherwise {
        stateReg := A // Return to A if r2 is deasserted
      }
      io.g := "b100".U // Grant Device 2 (g2)
    }
  }
}
