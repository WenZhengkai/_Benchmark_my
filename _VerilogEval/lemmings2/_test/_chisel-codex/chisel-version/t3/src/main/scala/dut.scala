import chisel3._
import chisel3.util._

class dut extends Module with RequireAsyncReset {
  val io = IO(new Bundle {
    val bump_left  = Input(Bool())
    val bump_right = Input(Bool())
    val ground     = Input(Bool())
    val walk_left  = Output(Bool())
    val walk_right = Output(Bool())
    val aaah       = Output(Bool())
  })

  // Moore FSM states
  val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)
  val state = RegInit(sWalkLeft) // async reset -> walk left

  switch(state) {
    is(sWalkLeft) {
      when(!io.ground) {
        state := sFallLeft
      }.elsewhen(io.bump_left) { // bump on left (or both) -> switch to right
        state := sWalkRight
      }.otherwise {
        state := sWalkLeft
      }
    }

    is(sWalkRight) {
      when(!io.ground) {
        state := sFallRight
      }.elsewhen(io.bump_right) { // bump on right (or both) -> switch to left
        state := sWalkLeft
      }.otherwise {
        state := sWalkRight
      }
    }

    is(sFallLeft) {
      when(io.ground) {
        state := sWalkLeft // resume pre-fall direction; bumps ignored
      }.otherwise {
        state := sFallLeft
      }
    }

    is(sFallRight) {
      when(io.ground) {
        state := sWalkRight // resume pre-fall direction; bumps ignored
      }.otherwise {
        state := sFallRight
      }
    }
  }

  // Moore outputs (depend only on state)
  io.walk_left  := (state === sWalkLeft)
  io.walk_right := (state === sWalkRight)
  io.aaah       := (state === sFallLeft) || (state === sFallRight)
}
