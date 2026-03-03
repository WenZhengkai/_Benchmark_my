import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define states
  val A :: B :: C :: D :: Nil = Enum(4)
  
  // State register
  val state = RegInit(A)
  
  // Extract individual request signals
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // Default grant output
  io.g := 0.U
  
  // FSM state transitions and outputs
  switch(state) {
    is(A) {
      // State A: No grants, check for requests with priority
      io.g := 0.U
      
      when(r0 === 1.U) {
        state := B
      } .elsewhen(r1 === 1.U) {
        state := C
      } .elsewhen(r2 === 1.U) {
        state := D
      } .otherwise {
        state := A
      }
    }
    
    is(B) {
      // State B: Grant to device 0
      io.g := 1.U  // g0 = 1, which is bit 0 set
      
      when(r0 === 1.U) {
        state := B
      } .otherwise {
        state := A
      }
    }
    
    is(C) {
      // State C: Grant to device 1
      io.g := 2.U  // g1 = 1, which is bit 1 set (binary: 010)
      
      when(r1 === 1.U) {
        state := C
      } .otherwise {
        state := A
      }
    }
    
    is(D) {
      // State D: Grant to device 2
      io.g := 4.U  // g2 = 1, which is bit 2 set (binary: 100)
      
      when(r2 === 1.U) {
        state := D
      } .otherwise {
        state := A
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
