import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states
  val stateA :: stateB :: stateC :: stateD :: Nil = Enum(4)
  val stateReg = RegInit(stateA)

  // Default outputs
  io.g := 0.U

  // State transitions and outputs
  switch(stateReg) {
    is(stateA) {
      when(io.r(0)) {
        stateReg := stateB
      }.elsewhen(!io.r(0) && io.r(1)) {
        stateReg := stateC
      }.elsewhen(io.r === "b100".U) {  // r0=0, r1=0, r2=1
        stateReg := stateD
      }
      // Otherwise stay in stateA
    }
    is(stateB) {
      io.g := "b001".U  // g0=1
      when(!io.r(0)) {
        stateReg := stateA
      }
      // If r0 stays 1, remain in stateB
    }
    is(stateC) {
      io.g := "b010".U  // g1=1
      when(!io.r(1)) {
        stateReg := stateA
      }
      // If r1 stays 1, remain in stateC
    }
    is(stateD) {
      io.g := "b100".U  // g2=1
      when(!io.r(2)) {
        stateReg := stateA
      }
      // If r2 stays 1, remain in stateD
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
