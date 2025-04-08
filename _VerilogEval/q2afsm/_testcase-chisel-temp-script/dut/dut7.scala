import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input for device requests
    val g = Output(UInt(3.W)) // 3-bit output for grants
  })

  // Enum for FSM states
  val sA :: sB :: sC :: sD :: Nil = Enum(4) // States: A, B, C, D

  val state = RegInit(State.A) // The current state of the FSM
  io.g := 0.U                  // Default value for the grant signals

  // FSM logic
  switch(state) {
    is(State.A) {
      when(io.r(0)) {
        state := State.B // Device 0 request, go to state B
      }.elsewhen(io.r(1)) {
        state := State.C // Device 1 request, go to state C
      }.elsewhen(io.r(2)) {
        state := State.D // Device 2 request, go to state D
      }.otherwise {
        state := State.A // Stay in state A if no requests
      }
    }

    is(State.B) {
      io.g := "b010".U // Grant signal for device 0 (g0 = 1)
      when(io.r(0)) {
        state := State.B // Stay in state B if device 0 continues to request
      }.otherwise {
        state := State.A // Go back to state A if device 0 stops requesting
      }
    }

    is(State.C) {
      io.g := "b010".U // Grant signal for device 1 (g1 = 1)
      when(io.r(1)) {
        state := State.C // Stay in state C if device 1 continues to request
      }.otherwise {
        state := State.A // Go back to state A if device 1 stops requesting
      }
    }

    is(State.D) {
      io.g := "b100".U // Grant signal for device 2 (g2 = 1)
      when(io.r(2)) {
        state := State.D // Stay in state D if device 2 continues to request
      }.otherwise {
        state := State.A // Go back to state A if device 2 stops requesting
      }
    }
  }
}

// Generate the Verilog for this FSM
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
