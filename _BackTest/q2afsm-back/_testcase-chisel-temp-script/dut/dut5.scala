import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  
  // State register with synchronous reset to state A
  val stateReg = RegInit(sA)

  // Default outputs
  io.g := 0.U

  // State transition logic
  switch(stateReg) {
    is(sA) {
      when(io.r(0)) {
        stateReg := sB
      }.elsewhen(!io.r(0) && io.r(1)) {
        stateReg := sC
      }.elsewhen(io.r === "b100".U) {  // Only r2 is 1 (r0=0, r1=0, r2=1)
        stateReg := sD
      }
      // Otherwise stay in sA
    }
    is(sB) {
      io.g := "b001".U  // g0=1
      when(!io.r(0)) {
        stateReg := sA
      }
      // If r0 stays 1, remain in sB
    }
    is(sC) {
      io.g := "b010".U  // g1=1
      when(!io.r(1)) {
        stateReg := sA
      }
      // If r1 stays 1, remain in sC
    }
    is(sD) {
      io.g := "b100".U  // g2=1
      when(!io.r(2)) {
        stateReg := sA
      }
      // If r2 stays 1, remain in sD
    }
  }
}

// Generate Verilog
/*
object dutMain extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
