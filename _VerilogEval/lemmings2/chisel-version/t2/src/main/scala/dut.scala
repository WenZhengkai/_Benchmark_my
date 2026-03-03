import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left  = Input(Bool())
    val bump_right = Input(Bool())
    val ground     = Input(Bool())

    val walk_left  = Output(Bool())
    val walk_right = Output(Bool())
    val aaah       = Output(Bool())
  })

  object State extends ChiselEnum {
    val walkLeft, walkRight, fallLeft, fallRight = Value
  }

  // Asynchronous, active-high reset to walkLeft
  val state = withReset(reset.asAsyncReset) {
    RegInit(State.walkLeft)
  }

  switch(state) {
    is(State.walkLeft) {
      when(!io.ground) {
        state := State.fallLeft
      }.elsewhen(io.bump_left || io.bump_right) {
        state := State.walkRight
      }
    }

    is(State.walkRight) {
      when(!io.ground) {
        state := State.fallRight
      }.elsewhen(io.bump_left || io.bump_right) {
        state := State.walkLeft
      }
    }

    is(State.fallLeft) {
      when(io.ground) {
        state := State.walkLeft
      }
    }

    is(State.fallRight) {
      when(io.ground) {
        state := State.walkRight
      }
    }
  }

  io.walk_left  := (state === State.walkLeft)
  io.walk_right := (state === State.walkRight)
  io.aaah       := (state === State.fallLeft) || (state === State.fallRight)
}
