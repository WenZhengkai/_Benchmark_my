import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Define the states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  val state = RegInit(sA)

  // Output logic
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g[0] = 1
    is(sC) { io.g := "b010".U } // g[1] = 1
    is(sD) { io.g := "b100".U } // g[2] = 1
  }

  // FSM logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB
      }.elsewhen(io.r(1)) {
        state := sC
      }.elsewhen(io.r(2)) {
        state := sD
      }
    }
    is(sB) {
      when(!io.r(0)) {
        state := sA
      }
    }
    is(sC) {
      when(!io.r(1)) {
        state := sA
      }
    }
    is(sD) {
      when(!io.r(2)) {
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
