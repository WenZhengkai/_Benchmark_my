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
  
  // Extract individual request bits
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // Default output
  io.g := 0.U
  
  // State machine logic
  switch(state) {
    is(sA) {
      io.g := 0.U
      when(r0 === 1.U) {
        state := sB
      }.elsewhen(r1 === 1.U) {
        state := sC
      }.elsewhen(r2 === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    
    is(sB) {
      io.g := 1.U  // g0 = 1, which is bit 0
      when(r0 === 1.U) {
        state := sB
      }.otherwise {
        state := sA
      }
    }
    
    is(sC) {
      io.g := 2.U  // g1 = 1, which is bit 1 (binary 010 = 2)
      when(r1 === 1.U) {
        state := sC
      }.otherwise {
        state := sA
      }
    }
    
    is(sD) {
      io.g := 4.U  // g2 = 1, which is bit 2 (binary 100 = 4)
      when(r2 === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
