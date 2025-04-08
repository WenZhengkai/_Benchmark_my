import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Task 1: State Enumeration & Reset Implementation
  // Define the states using Enum
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // Create a state register with asynchronous reset to WalkLeft
  val state = RegInit(State.WalkLeft)

  // Task 2 & 3: State Transitions
  // Define the next state based on the current state and inputs
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.FallLeft // Falling when there's no ground
      } .elsewhen(io.bump_left) {
        state := State.WalkRight // Change direction if bumping left
      } .otherwise {
        state := State.WalkLeft // Keep walking left otherwise
      }
    }

    is(State.WalkRight) {
      when(!io.ground) {
        state := State.FallRight // Falling when there's no ground
      } .elsewhen(io.bump_right) {
        state := State.WalkLeft // Change direction if bumping right
      } .otherwise {
        state := State.WalkRight // Keep walking right otherwise
      }
    }

    is(State.FallLeft) {
      when(io.ground) {
        state := State.WalkLeft // Back to walking left when ground is available
      } .otherwise {
        state := State.FallLeft // Stay in falling left otherwise
      }
    }

    is(State.FallRight) {
      when(io.ground) {
        state := State.WalkRight // Back to walking right when ground is available
      } .otherwise {
        state := State.FallRight // Stay in falling right otherwise
      }
    }
  }

  // Task 4: Output Logic
  // Combinatorial logic to generate outputs based on current state
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft) || (state === State.FallRight)

  // Task 5: Edge Case Handling
  // (Implicitly handled: Inputs `bump_left` and `bump_right` are ignored during falling states
  // and transitions based on states ensure no impact of bumps when transitioning.)
}

// For testing in a Chisel environment, add a testbench (e.g., using ChiselTest) if needed.
