import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define states
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  import State._

  // State register
  val state = RegInit(A)
  
  // Default output value
  io.g := 0.U
  
  // Extract individual request bits for clarity
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // FSM state transitions
  switch(state) {
    is(A) {
      when(r0) {
        state := B
      }.elsewhen(r1) {
        state := C
      }.elsewhen(r2) {
        state := D
      }.otherwise {
        state := A
      }
    }
    
    is(B) {
      // g0 = 1 in state B
      io.g := "b001".U
      when(r0) {
        state := B
      }.otherwise {
        state := A
      }
    }
    
    is(C) {
      // g1 = 1 in state C
      io.g := "b010".U
      when(r1) {
        state := C
      }.otherwise {
        state := A
      }
    }
    
    is(D) {
      // g2 = 1 in state D
      io.g := "b100".U
      when(r2) {
        state := D
      }.otherwise {
        state := A
      }
    }
  }
}
