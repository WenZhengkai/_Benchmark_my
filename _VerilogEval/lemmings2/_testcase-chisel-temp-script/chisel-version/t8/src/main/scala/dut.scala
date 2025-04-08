import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val reset = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Task 1: Define FSM States
  val WalkLeft :: WalkRight :: Fall :: Nil = Enum(3)
  val state = RegInit(WalkLeft)
  val preservedDirection = RegInit(WalkLeft) // Store the walking direction in case of falling

  // Task 2: Define I/O Ports (already handled by the IO bundle above)

  // Task 3: Implement reset functionality
  when(io.reset) {
    state := WalkLeft
    preservedDirection := WalkLeft
  }

  // State transition logic
  switch(state) {
    // WalkLeft state logic
    is(WalkLeft) {
      when(!io.ground) {
        // Transition to Fall state if no ground, preserving WalkLeft direction
        state := Fall
        preservedDirection := WalkLeft
      }.elsewhen(io.bump_left || (io.bump_left && io.bump_right)) {
        // Bumped into left, transition to WalkRight
        state := WalkRight
      }
    }

    // WalkRight state logic
    is(WalkRight) {
      when(!io.ground) {
        // Transition to Fall state if no ground, preserving WalkRight direction
        state := Fall
        preservedDirection := WalkRight
      }.elsewhen(io.bump_right || (io.bump_left && io.bump_right)) {
        // Bumped into right, transition to WalkLeft
        state := WalkLeft
      }
    }

    // Fall state logic
    is(Fall) {
      when(io.ground) {
        // When ground is restored, return to previous walking direction
        state := preservedDirection
      }
    }
  }

  // Task 6 & 7: Output logic
  io.walk_left := state === WalkLeft
  io.walk_right := state === WalkRight
  io.aaah := state === Fall
}

// For testing purposes, you can also include a Driver or Tester (if needed), but the above defines the essential module.
