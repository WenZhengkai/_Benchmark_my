import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input for requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Define states using Chisel Enum
  object State extends ChiselEnum {
    val A, B, C, D = Value // States A, B, C, D
  }
  import State._

  val state = RegInit(State.A) // State register initialized to state A

  // Default output for grants
  io.g := 0.U

  // Next state logic and output grants based on the current state and input
  switch(state) {
    is(A) { // State A
      when(io.r(0)) {
        state := B // Transition to state B if r0 is high
      }.elsewhen(io.r(1)) {
        state := C // Transition to state C if r1 is high and r0 is low
      }.elsewhen(io.r(2)) {
        state := D // Transition to state D if r2 is high and r0/r1 are low
      }
    }

    is(B) { // State B - Grants device 0
      io.g := "b001".U // g(0) = 1
      when(!io.r(0)) {
        state := A // Transition to state A if r0 is low
      }
    }

    is(C) { // State C - Grants device 1
      io.g := "b010".U // g(1) = 1
      when(!io.r(1)) {
        state := A // Transition to state A if r1 is low
      }
    }

    is(D) { // State D - Grants device 2
      io.g := "b100".U // g(2) = 1
      when(!io.r(2)) {
        state := A // Transition to state A if r2 is low
      }
    }
  }
}

// Generate Verilog for the module
/*
object dutMake extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
