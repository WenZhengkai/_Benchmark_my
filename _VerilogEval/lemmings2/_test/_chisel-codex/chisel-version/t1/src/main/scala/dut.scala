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

  // Asynchronous active-high reset to walkLeft
  val state = withReset(reset.asAsyncReset) {
    RegInit(State.walkLeft)
  }

  switch(state) {
    is(State.walkLeft) {
      when(!io.ground) {
        // Start falling; ignore bumps this cycle
        state := State.fallLeft
      }.otherwise {
        when(io.bump_left && io.bump_right) {
          state := State.walkRight // both bumps => switch direction
        }.elsewhen(io.bump_left) {
          state := State.walkRight
        }.elsewhen(io.bump_right) {
          state := State.walkLeft
        }
      }
    }

    is(State.walkRight) {
      when(!io.ground) {
        // Start falling; ignore bumps this cycle
        state := State.fallRight
      }.otherwise {
        when(io.bump_left && io.bump_right) {
          state := State.walkLeft // both bumps => switch direction
        }.elsewhen(io.bump_right) {
          state := State.walkLeft
        }.elsewhen(io.bump_left) {
          state := State.walkRight
        }
      }
    }

    is(State.fallLeft) {
      when(io.ground) {
        // Ground reappears; resume previous direction, ignore bumps this cycle
        state := State.walkLeft
      }
    }

    is(State.fallRight) {
      when(io.ground) {
        // Ground reappears; resume previous direction, ignore bumps this cycle
        state := State.walkRight
      }
    }
  }

  // Moore outputs
  io.walk_left  := (state === State.walkLeft)
  io.walk_right := (state === State.walkRight)
  io.aaah       := (state === State.fallLeft) || (state === State.fallRight)
}
