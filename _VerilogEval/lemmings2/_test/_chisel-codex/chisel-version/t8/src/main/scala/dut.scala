import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

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

  // Asynchronous active-high reset to walkLeft
  val state = withReset(reset.asAsyncReset) {
    RegInit(State.walkLeft)
  }

  val nextState = WireDefault(state)

  switch(state) {
    is(State.walkLeft) {
      when(!io.ground) {
        nextState := State.fallLeft
      }.elsewhen(io.bump_left) {
        // Includes bump_left && bump_right: still switch direction
        nextState := State.walkRight
      }
    }

    is(State.walkRight) {
      when(!io.ground) {
        nextState := State.fallRight
      }.elsewhen(io.bump_right) {
        // Includes bump_left && bump_right: still switch direction
        nextState := State.walkLeft
      }
    }

    is(State.fallLeft) {
      // Bumps while falling are ignored
      when(io.ground) {
        nextState := State.walkLeft
      }
    }

    is(State.fallRight) {
      // Bumps while falling are ignored
      when(io.ground) {
        nextState := State.walkRight
      }
    }
  }

  state := nextState

  // Moore outputs depend only on current state
  io.walk_left  := (state === State.walkLeft)
  io.walk_right := (state === State.walkRight)
  io.aaah       := (state === State.fallLeft) || (state === State.fallRight)
}
