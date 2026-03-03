import chisel3._
import chisel3.util._

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  import State._

  val state = RegInit(A)

  // Next-state logic
  switch(state) {
    is(A) {
      when(io.r(0)) {
        state := B
      }.elsewhen(io.r(1)) {
        state := C
      }.elsewhen(io.r(2)) {
        state := D
      }.otherwise {
        state := A
      }
    }
    is(B) {
      when(io.r(0)) { state := B }
        .otherwise { state := A }
    }
    is(C) {
      when(io.r(1)) { state := C }
        .otherwise { state := A }
    }
    is(D) {
      when(io.r(2)) { state := D }
        .otherwise { state := A }
    }
  }

  // Output logic
  io.g := 0.U
  switch(state) {
    is(B) { io.g := "b001".U } // g0 = 1
    is(C) { io.g := "b010".U } // g1 = 1
    is(D) { io.g := "b100".U } // g2 = 1
  }
}
