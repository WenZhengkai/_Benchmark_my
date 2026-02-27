import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states of the FSM
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // State register
  val stateReg = RegInit(sA)

  // Output grant signals
  io.g := 0.U

  // FSM logic
  switch(stateReg) {
    is(sA) {
      when(io.r(0) === 1.U) {
        stateReg := sB
      }.elsewhen(io.r(1) === 1.U) {
        stateReg := sC
      }.elsewhen(io.r(2) === 1.U) {
        stateReg := sD
      }
    }
    is(sB) {
      io.g := "b001".U
      when(io.r(0) === 0.U) {
        stateReg := sA
      }
    }
    is(sC) {
      io.g := "b010".U
      when(io.r(1) === 0.U) {
        stateReg := sA
      }
    }
    is(sD) {
      io.g := "b100".U
      when(io.r(2) === 0.U) {
        stateReg := sA
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
