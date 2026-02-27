// package arbiter

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
  import State._

  // State register
  val state = RegInit(A)
  
  // Default output value
  io.g := 0.U
  
  // Extract individual request bits for readability
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)

  // FSM implementation
  switch(state) {
    is(A) {
      when(r0 === 1.U) {
        state := B
      }.elsewhen(r0 === 0.U && r1 === 1.U) {
        state := C
      }.elsewhen(r0 === 0.U && r1 === 0.U && r2 === 1.U) {
        state := D
      }.otherwise {
        state := A
      }
    }
    
    is(B) {
      // Set grant for device 0
      io.g := "b001".U
      
      when(r0 === 0.U) {
        state := A
      }.otherwise {
        state := B
      }
    }
    
    is(C) {
      // Set grant for device 1
      io.g := "b010".U
      
      when(r1 === 0.U) {
        state := A
      }.otherwise {
        state := C
      }
    }
    
    is(D) {
      // Set grant for device 2
      io.g := "b100".U
      
      when(r2 === 0.U) {
        state := A
      }.otherwise {
        state := D
      }
    }
  }
}
