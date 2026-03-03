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

  // Asynchronous, active-high reset to "walk left"
  withReset(reset.asAsyncReset) {

    object State extends ChiselEnum {
      val WalkLeft, WalkRight, FallLeft, FallRight = Value
    }
    import State._

    val state = RegInit(WalkLeft)

    // Next-state logic (Moore FSM)
    switch(state) {
      is(WalkLeft) {
        when(!io.ground) {
          // ground disappears: start falling, preserve direction
          state := FallLeft
        }.elsewhen(io.bump_left || io.bump_right) {
          // bumped while walking: switch direction (either side, or both)
          state := WalkRight
        }.otherwise {
          state := WalkLeft
        }
      }

      is(WalkRight) {
        when(!io.ground) {
          state := FallRight
        }.elsewhen(io.bump_left || io.bump_right) {
          state := WalkLeft
        }.otherwise {
          state := WalkRight
        }
      }

      is(FallLeft) {
        // While falling, bumps do not affect direction.
        // When ground returns, resume walking in the same direction.
        when(io.ground) {
          state := WalkLeft
        }.otherwise {
          state := FallLeft
        }
      }

      is(FallRight) {
        when(io.ground) {
          state := WalkRight
        }.otherwise {
          state := FallRight
        }
      }
    }

    // Moore outputs depend only on state
    io.walk_left  := (state === WalkLeft)
    io.walk_right := (state === WalkRight)
    io.aaah       := (state === FallLeft) || (state === FallRight)
  }
}
