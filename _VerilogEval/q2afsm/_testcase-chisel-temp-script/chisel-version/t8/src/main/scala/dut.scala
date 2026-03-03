import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // Use Bool reset (synchronous reset behavior)
  val state = withClockAndReset(clock, reset.asBool) {
    RegInit(sA)
  }

  // Next-state logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB
      }.elsewhen(io.r(1)) {
        state := sC
      }.elsewhen(io.r(2)) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    is(sB) {
      when(io.r(0)) { state := sB } .otherwise { state := sA }
    }
    is(sC) {
      when(io.r(1)) { state := sC } .otherwise { state := sA }
    }
    is(sD) {
      when(io.r(2)) { state := sD } .otherwise { state := sA }
    }
  }

  // Output logic (grant signals)
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g0 = 1
    is(sC) { io.g := "b010".U } // g1 = 1
    is(sD) { io.g := "b100".U } // g2 = 1
  }
}
