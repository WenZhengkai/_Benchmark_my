import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // State register with synchronous reset
  val stateReg = RegInit(sA)

  // Output logic
  io.g := 0.U
  switch(stateReg) {
    is(sB) { io.g := "b001".U }
    is(sC) { io.g := "b010".U }
    is(sD) { io.g := "b100".U }
  }

  // Next state logic
  switch(stateReg) {
    is(sA) {
      when(io.r(0)) {
        stateReg := sB
      }.elsewhen(io.r(1)) {
        stateReg := sC
      }.elsewhen(io.r(2)) {
        stateReg := sD
      }
    }
    is(sB) {
      when(!io.r(0)) {
        stateReg := sA
      }
    }
    is(sC) {
      when(!io.r(1)) {
        stateReg := sA
      }
    }
    is(sD) {
      when(!io.r(2)) {
        stateReg := sA
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
