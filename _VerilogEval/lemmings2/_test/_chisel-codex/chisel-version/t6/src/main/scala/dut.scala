import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut extends RawModule {
  val clock = IO(Input(Clock()))
  val reset = IO(Input(AsyncReset()))

  val bump_left  = IO(Input(Bool()))
  val bump_right = IO(Input(Bool()))
  val ground     = IO(Input(Bool()))

  val walk_left  = IO(Output(Bool()))
  val walk_right = IO(Output(Bool()))
  val aaah       = IO(Output(Bool()))

  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  withClockAndReset(clock, reset) {
    val state = RegInit(State.WalkLeft)

    switch(state) {
      is(State.WalkLeft) {
        when(!ground) {
          state := State.FallLeft // ground disappears: start falling, keep direction memory
        }.otherwise {
          // While walking left: switch only if bumped on left (both bumps also switches)
          when(bump_left) { state := State.WalkRight }
            .otherwise    { state := State.WalkLeft }
        }
      }

      is(State.WalkRight) {
        when(!ground) {
          state := State.FallRight
        }.otherwise {
          // While walking right: switch only if bumped on right (both bumps also switches)
          when(bump_right) { state := State.WalkLeft }
            .otherwise     { state := State.WalkRight }
        }
      }

      is(State.FallLeft) {
        // Ignore bumps while falling and when ground reappears
        when(ground) { state := State.WalkLeft }
      }

      is(State.FallRight) {
        when(ground) { state := State.WalkRight }
      }
    }

    walk_left  := (state === State.WalkLeft)
    walk_right := (state === State.WalkRight)
    aaah       := (state === State.FallLeft) || (state === State.FallRight)
  }
}
