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

  // Define the states
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallingLeft, FallingRight = Value
  }

  val state = RegInit(State.WalkLeft)

  // Default outputs
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State machine logic
  switch(state) {
    is(State.WalkLeft) {
      io.walk_left := true.B
      when(!io.ground) { // Ground disappears, start falling
        state := State.FallingLeft
      }.elsewhen(io.bump_left) { // Bumped on the left, switch to WalkRight
        state := State.WalkRight
      }
    }
    is(State.WalkRight) {
      io.walk_right := true.B
      when(!io.ground) { // Ground disappears, start falling
        state := State.FallingRight
      }.elsewhen(io.bump_right) { // Bumped on the right, switch to WalkLeft
        state := State.WalkLeft
      }
    }
    is(State.FallingLeft) {
      io.aaah := true.B
      when(io.ground) { // Ground reappears, resume walking left
        state := State.WalkLeft
      }
    }
    is(State.FallingRight) {
      io.aaah := true.B
      when(io.ground) { // Ground reappears, resume walking right
        state := State.WalkRight
      }
    }
  }
}

