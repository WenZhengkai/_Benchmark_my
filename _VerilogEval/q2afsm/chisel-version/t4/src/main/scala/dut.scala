import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // FSM state definitions
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  import State._

  // State register
  val state = RegInit(A)
  
  // Default output values
  io.g := 0.U
  
  // Extract individual request bits for easier reading
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // FSM logic
  switch(state) {
    is(A) {
      // State transitions from A based on priority
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
      // Set grant for device 0
      io.g := "b001".U
      
      // State transitions from B
      when(r0) {
        state := B
      }.otherwise {
        state := A
      }
    }
    
    is(C) {
      // Set grant for device 1
      io.g := "b010".U
      
      // State transitions from C
      when(r1) {
        state := C
      }.otherwise {
        state := A
      }
    }
    
    is(D) {
      // Set grant for device 2
      io.g := "b100".U
      
      // State transitions from D
      when(r2) {
        state := D
      }.otherwise {
        state := A
      }
    }
  }
}
