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

  // State transitions and outputs
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB
      }.elsewhen(!io.r(0) && io.r(1)) {
        state := sC
      }.elsewhen(io.r === "b100".U) {  // r0=0, r1=0, r2=1
        state := sD
      }
      // Otherwise stay in sA (implicit)
    }
    is(sB) {
      io.g := "b001".U  // g0=1
      when(!io.r(0)) {
        state := sA
      }
      // If r0 stays 1, remain in sB (implicit)
    }
    is(sC) {
      io.g := "b010".U  // g1=1
      when(!io.r(1)) {
        state := sA
      }
      // If r1 stays 1, remain in sC (implicit)
    }
    is(sD) {
      io.g := "b100".U  // g2=1
      when(!io.r(2)) {
        state := sA
      }
      // If r2 stays 1, remain in sD (implicit)
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
