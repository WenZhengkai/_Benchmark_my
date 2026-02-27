import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  // State register
  val state = RegInit(State.A)
  
  // Default output
  io.g := 0.U
  
  // Extract individual request bits
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // FSM logic
  switch(state) {
    is(State.A) {
      when(r0) {
        state := State.B
      }.elsewhen(r1) {
        state := State.C
      }.elsewhen(r2) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }
    
    is(State.B) {
      io.g := "b001".U  // g0 = 1
      when(r0) {
        state := State.B
      }.otherwise {
        state := State.A
      }
    }
    
    is(State.C) {
      io.g := "b010".U  // g1 = 1
      when(r1) {
        state := State.C
      }.otherwise {
        state := State.A
      }
    }
    
    is(State.D) {
      io.g := "b100".U  // g2 = 1
      when(r2) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }
  }
}
