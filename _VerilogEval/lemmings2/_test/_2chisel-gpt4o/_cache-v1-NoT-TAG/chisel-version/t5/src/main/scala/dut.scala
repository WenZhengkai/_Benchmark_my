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

  // Task 1: State Enumeration & Reset Implementation
  // Define the states as an enumeration
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  val state = RegInit(State.WalkLeft) // Initialize FSM with WalkLeft state

  // Task 2 and Task 3: State Transition Logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.FallLeft // Transition to FallLeft if ground = 0
      }.elsewhen(io.bump_left) {
        state := State.WalkRight // Change direction to WalkRight if bumped
      }
    }

    is(State.WalkRight) {
      when(!io.ground) {
        state := State.FallRight // Transition to FallRight if ground = 0
      }.elsewhen(io.bump_right) {
        state := State.WalkLeft // Change direction to WalkLeft if bumped
      }
    }

    is(State.FallLeft) {
      when(io.ground) {
        state := State.WalkLeft // Return to WalkLeft when ground = 1
      }
    }

    is(State.FallRight) {
      when(io.ground) {
        state := State.WalkRight // Return to WalkRight when ground = 1
      }
    }
  }

  // Task 4: Output Logic
  // Combinational logic for outputs based on the current state
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft || state === State.FallRight)
}
