import chisel3._
import chisel3.util._

object dutState extends ChiselEnum {
  val A, B, C, D = Value
}

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input signal for requests
    val g = Output(UInt(3.W)) // 3-bit output signal for grants
  })

  import dutState._

  // State register: Initialize to state A
  val state = RegInit(A)

  // Default output (all grants are 0 by default)
  io.g := 0.U

  // State transition and output logic
  switch(state) {
    is(A) {
      // State A logic
      when(io.r(0)) {
        state := B // Transition to state B
      }.elsewhen(io.r(1)) {
        state := C // Transition to state C
      }.elsewhen(io.r(2)) {
        state := D // Transition to state D
      }.otherwise {
        state := A // Stay in state A
      }
    }

    is(B) {
      // State B logic
      io.g := "b001".U // Grant to device 0
      when(io.r(0)) {
        state := B // Stay in state B
      }.otherwise {
        state := A // Transition back to state A
      }
    }

    is(C) {
      // State C logic
      io.g := "b010".U // Grant to device 1
      when(io.r(1)) {
        state := C // Stay in state C
      }.otherwise {
        state := A // Transition back to state A
      }
    }

    is(D) {
      // State D logic
      io.g := "b100".U // Grant to device 2
      when(io.r(2)) {
        state := D // Stay in state D
      }.otherwise {
        state := A // Transition back to state A
      }
    }
  }
}

// Main object to generate Verilog
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
