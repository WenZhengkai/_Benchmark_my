import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  object State extends ChiselEnum {
    val A, B, C, D = Value
  }

  val state = RegInit(State.A)

  // Next-state logic
  switch(state) {
    is(State.A) {
      when(io.r(0)) {
        state := State.B
      }.elsewhen(io.r(1)) {
        state := State.C
      }.elsewhen(io.r(2)) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }

    is(State.B) {
      when(io.r(0)) { state := State.B }
        .otherwise   { state := State.A }
    }

    is(State.C) {
      when(io.r(1)) { state := State.C }
        .otherwise   { state := State.A }
    }

    is(State.D) {
      when(io.r(2)) { state := State.D }
        .otherwise   { state := State.A }
    }
  }

  // Output logic (Moore outputs)
  io.g := MuxLookup(
    state.asUInt,
    "b000".U,
    Seq(
      State.B.asUInt -> "b001".U, // g0 = 1
      State.C.asUInt -> "b010".U, // g1 = 1
      State.D.asUInt -> "b100".U  // g2 = 1
    )
  )
}
