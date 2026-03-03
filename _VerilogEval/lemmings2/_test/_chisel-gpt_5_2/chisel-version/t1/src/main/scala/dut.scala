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

  // Moore FSM states
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }
  import State._

  // Async reset to walking left (as specified)
  val state = withReset(reset.asAsyncReset) { RegInit(WalkLeft) }

  // Next-state logic
  switch(state) {
    is(WalkLeft) {
      when(!io.ground) {
        // Start falling; bumps in this same cycle do not affect direction
        state := FallLeft
      }.elsewhen(io.bump_left || io.bump_right) {
        // Any bump while walking flips direction
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
      when(io.ground) {
        // Resume prior direction; bumps during fall or on reappearance don't matter
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

  // Moore outputs
  io.walk_left  := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah       := (state === FallLeft) || (state === FallRight)
}
