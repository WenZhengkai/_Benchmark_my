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

  // Output logic
  io.g := 0.U  // Default all grants to 0
  switch(stateReg) {
    is(sB) { io.g := "b001".U }  // g0=1
    is(sC) { io.g := "b010".U }  // g1=1
    is(sD) { io.g := "b100".U }  // g2=1
  }

  // Next state logic
  switch(stateReg) {
    is(sA) {
      when(io.r(0)) {
        stateReg := sB
      }.elsewhen(!io.r(0) && io.r(1)) {
        stateReg := sC
      }.elsewhen(io.r === "b100".U) {  // r0=0, r1=0, r2=1
        stateReg := sD
      }
      // Otherwise stay in state A
    }
    is(sB) {
      when(!io.r(0)) {
        stateReg := sA
      } // Otherwise stay in state B
    }
    is(sC) {
      when(!io.r(1)) {
        stateReg := sA
      } // Otherwise stay in state C
    }
    is(sD) {
      when(!io.r(2)) {
        stateReg := sA
      } // Otherwise stay in state D
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
