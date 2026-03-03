import chisel3._

class dut extends RawModule {
  val clock      = IO(Input(Clock()))
  val reset      = IO(Input(AsyncReset()))

  val bump_left  = IO(Input(Bool()))
  val bump_right = IO(Input(Bool()))
  val ground     = IO(Input(Bool()))

  val walk_left  = IO(Output(Bool()))
  val walk_right = IO(Output(Bool()))
  val aaah       = IO(Output(Bool()))

  withClockAndReset(clock, reset) {
    val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)
    val state = RegInit(sWalkLeft) // async reset -> walk left

    switch(state) {
      is(sWalkLeft) {
        when(!ground) {
          state := sFallLeft // ground disappears: start falling, ignore bumps this cycle
        }.elsewhen(bump_left) {
          state := sWalkRight // left bump (or both bumps) while walking left -> switch
        }.otherwise {
          state := sWalkLeft
        }
      }

      is(sWalkRight) {
        when(!ground) {
          state := sFallRight // ground disappears: start falling, ignore bumps this cycle
        }.elsewhen(bump_right) {
          state := sWalkLeft // right bump (or both bumps) while walking right -> switch
        }.otherwise {
          state := sWalkRight
        }
      }

      is(sFallLeft) {
        when(ground) {
          state := sWalkLeft // ground reappears: resume previous direction, ignore bumps
        }.otherwise {
          state := sFallLeft
        }
      }

      is(sFallRight) {
        when(ground) {
          state := sWalkRight // ground reappears: resume previous direction, ignore bumps
        }.otherwise {
          state := sFallRight
        }
      }
    }

    // Moore outputs
    walk_left  := (state === sWalkLeft)
    walk_right := (state === sWalkRight)
    aaah       := (state === sFallLeft) || (state === sFallRight)
  }
}
