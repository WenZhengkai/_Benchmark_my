import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })
  
  // Define states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sA)
  
  // Default output value
  io.g := 0.U
  
  // FSM logic
  switch(state) {
    is(sA) {
      // Priority encoding for next state transitions
      when(io.r(0) === 1.U) {
        state := sB
      }.elsewhen(io.r(1) === 1.U) {
        state := sC
      }.elsewhen(io.r(2) === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    
    is(sB) {
      // Device 0 has grant
      io.g := "b001".U
      
      when(io.r(0) === 0.U) {
        state := sA
      }.otherwise {
        state := sB
      }
    }
    
    is(sC) {
      // Device 1 has grant
      io.g := "b010".U
      
      when(io.r(1) === 0.U) {
        state := sA
      }.otherwise {
        state := sC
      }
    }
    
    is(sD) {
      // Device 2 has grant
      io.g := "b100".U
      
      when(io.r(2) === 0.U) {
        state := sA
      }.otherwise {
        state := sD
      }
    }
  }
}
