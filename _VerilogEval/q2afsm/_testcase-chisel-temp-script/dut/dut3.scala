import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // FSM states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sA)
  
  // Extract individual request signals for clarity
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // Default output
  io.g := 0.U
  
  // State transition logic and output logic
  switch(state) {
    is(sA) {
      when(r0 === 1.U) {
        state := sB
      }.elsewhen(r0 === 0.U && r1 === 1.U) {
        state := sC
      }.elsewhen(r0 === 0.U && r1 === 0.U && r2 === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    
    is(sB) {
      io.g := "b001".U  // g0 = 1, grant device 0
      when(r0 === 0.U) {
        state := sA
      }.otherwise {
        state := sB
      }
    }
    
    is(sC) {
      io.g := "b010".U  // g1 = 1, grant device 1
      when(r1 === 0.U) {
        state := sA
      }.otherwise {
        state := sC
      }
    }
    
    is(sD) {
      io.g := "b100".U  // g2 = 1, grant device 2
      when(r2 === 0.U) {
        state := sA
      }.otherwise {
        state := sD
      }
    }
  }
}
