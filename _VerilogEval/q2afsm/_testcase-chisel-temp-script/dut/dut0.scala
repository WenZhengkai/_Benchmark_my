import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input representing requests from the devices
    val g = Output(UInt(3.W)) // 3-bit output representing grants to the devices
  })

  // FSM State Encoding
  val sA :: sB :: sC :: sD :: Nil = Enum(4) // States: A, B, C, D
  val state = RegInit(sA) // Initialize the FSM in state A

  // Default outputs (all grants are inactive by default)
  io.g := 0.U

  // FSM State Transition Logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB // Priority to device 0
      }.elsewhen(io.r(1)) {
        state := sC // Priority to device 1 if device 0 is not requesting
      }.elsewhen(io.r(2)) {
        state := sD // Priority to device 2 if both device 0 and 1 are not requesting
      }
    }
    is(sB) {
      io.g := "b001".U // Grant to device 0
      when(!io.r(0)) {
        state := sA // Go back to state A if device 0 stops requesting
      }
    }
    is(sC) {
      io.g := "b010".U // Grant to device 1
      when(!io.r(1)) {
        state := sA // Go back to state A if device 1 stops requesting
      }
    }
    is(sD) {
      io.g := "b100".U // Grant to device 2
      when(!io.r(2)) {
        state := sA // Go back to state A if device 2 stops requesting
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
