import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // State enumeration
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  
  // State register
  val state = RegInit(State.A)
  
  // Default output value
  io.g := 0.U
  
  // Extract individual request bits for easier reference
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // FSM implementation
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
      // In state B, g0 = 1
      io.g := "b001".U
      
      when(r0) {
        state := State.B
      }.otherwise {
        state := State.A
      }
    }
    
    is(State.C) {
      // In state C, g1 = 1
      io.g := "b010".U
      
      when(r1) {
        state := State.C
      }.otherwise {
        state := State.A
      }
    }
    
    is(State.D) {
      // In state D, g2 = 1
      io.g := "b100".U
      
      when(r2) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }
  }
}

// Optional: Object for generating Verilog
/*
object dutDriver extends App {
  chisel3.emitVerilog(new dut, args)
}
*/
