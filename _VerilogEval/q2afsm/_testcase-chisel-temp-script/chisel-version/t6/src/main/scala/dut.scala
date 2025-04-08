import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit request input
    val g = Output(UInt(3.W)) // 3-bit grant output
  })

  // Define states as an enumeration
  object State extends ChiselEnum {
    val sA, sB, sC, sD = Value
  }

  import State._

  // State register
  val state = RegInit(sA)
  
  // Default output
  io.g := 0.U

  // State transition logic
  switch(state) {
    is(sA) { // State A
      when(io.r(0)) {
        state := sB
      } .elsewhen(io.r(1)) {
        state := sC
      } .elsewhen(io.r(2)) {
        state := sD
      } .otherwise {
        state := sA
      }
    }
    is(sB) { // State B
      io.g := "b001".U // g0 = 1, others = 0
      when(io.r(0)) {
        state := sB
      } .otherwise {
        state := sA
      }
    }
    is(sC) { // State C
      io.g := "b010".U // g1 = 1, others = 0
      when(io.r(1)) {
        state := sC
      } .otherwise {
        state := sA
      }
    }
    is(sD) { // State D
      io.g := "b100".U // g2 = 1, others = 0
      when(io.r(2)) {
        state := sD
      } .otherwise {
        state := sA
      }
    }
  }
}

/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
