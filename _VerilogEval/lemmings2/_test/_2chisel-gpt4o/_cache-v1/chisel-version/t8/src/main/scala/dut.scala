import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())    // 1: bumped on the left
    val bump_right = Input(Bool())   // 1: bumped on the right
    val ground = Input(Bool())       // 1: ground present, 0: falling
    val walk_left = Output(Bool())   // 1: walking left
    val walk_right = Output(Bool())  // 1: walking right
    val aaah = Output(Bool())        // 1: falling
  })

  // Define states for the state machine
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallingLeft, FallingRight = Value
  }

  // State register
  val state = RegInit(State.WalkLeft)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State transition logic
  switch(state) {
    is(State.WalkLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        state := State.FallingLeft
      }.elsewhen(io.bump_left || (io.bump_left && io.bump_right)) {
        state := State.WalkRight
      }
    }

    is(State.WalkRight) {
      io.walk_right := true.B
      when(!io.ground) {
        state := State.FallingRight
      }.elsewhen(io.bump_right || (io.bump_left && io.bump_right)) {
        state := State.WalkLeft
      }
    }

    is(State.FallingLeft) {
      io.aaah := true.B
      when(io.ground) {
        state := State.WalkLeft
      }
    }

    is(State.FallingRight) {
      io.aaah := true.B
      when(io.ground) {
        state := State.WalkRight
      }
    }
  }
}

