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

  // Default outputs
  io.g := 0.U

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
      io.g := "b001".U
      when(!io.r(0)) {
        state := sA
      }
    }
    is(sC) {
      io.g := "b010".U
      when(!io.r(1)) {
        state := sA
      }
    }
    is(sD) {
      io.g := "b100".U
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
