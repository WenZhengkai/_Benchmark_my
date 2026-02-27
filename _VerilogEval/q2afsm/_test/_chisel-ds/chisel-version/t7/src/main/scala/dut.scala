import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states
  val stateA :: stateB :: stateC :: stateD :: Nil = Enum(4)

  // State register with synchronous reset
  val stateReg = RegInit(stateA)

  // Default outputs
  io.g := 0.U

  // FSM logic
  switch(stateReg) {
    is(stateA) {
      when(io.r(0)) {
        stateReg := stateB
      }.elsewhen(io.r(1)) {
        stateReg := stateC
      }.elsewhen(io.r(2)) {
        stateReg := stateD
      }
    }
    is(stateB) {
      io.g := "b001".U
      when(!io.r(0)) {
        stateReg := stateA
      }
    }
    is(stateC) {
      io.g := "b010".U
      when(!io.r(1)) {
        stateReg := stateA
      }
    }
    is(stateD) {
      io.g := "b100".U
      when(!io.r(2)) {
        stateReg := stateA
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
