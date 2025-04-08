import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())  // Input: Bump into an obstacle on the left
    val bump_right = Input(Bool()) // Input: Bump into an obstacle on the right
    val ground = Input(Bool())     // Input: Indicates if the Lemming is on the ground
    val walk_left = Output(Bool()) // Output: The Lemming is walking left
    val walk_right = Output(Bool()) // Output: The Lemming is walking right
    val aaah = Output(Bool())       // Output: The Lemming is falling (screaming)
  })

  // ** Task 1: State Enumeration & Reset Implementation **
  // Define states using Chisel's `Enum` construct
  val (WalkLeft :: WalkRight :: FallLeft :: FallRight :: Nil) = Enum(4)
  
  // State register with reset to `WalkLeft` (initial state)
  val state = RegInit(WalkLeft)

  // ** Task 2: Walking State Transitions **
  switch(state) {
    is(WalkLeft) {
      // If the ground disappears, transition to falling
      when(!io.ground) {
        state := FallLeft
      }.elsewhen(io.bump_left) {
        // On bump to the left, switch to walking right
        state := WalkRight
      }
      // Otherwise, remain in WalkLeft
    }
    is(WalkRight) {
      // If the ground disappears, transition to falling
      when(!io.ground) {
        state := FallRight
      }.elsewhen(io.bump_right) {
        // On bump to the right, switch to walking left
        state := WalkLeft
      }
      // Otherwise, remain in WalkRight
    }

    // ** Task 3: Falling State Transitions **
    is(FallLeft) {
      // Falling continues until the ground reappears
      when(io.ground) {
        state := WalkLeft
      }
      // Otherwise, remain in FallLeft
    }
    is(FallRight) {
      // Falling continues until the ground reappears
      when(io.ground) {
        state := WalkRight
      }
      // Otherwise, remain in FallRight
    }
  }

  // ** Task 4: Output Logic **
  // Set outputs combinatorially based on state (Moore Machine Outputs)
  io.walk_left := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah := (state === FallLeft) || (state === FallRight)
  
  // ** Task 5: Edge Case Handling **
  // By design, bumps have no effect during falling states (FallLeft, FallRight).
  // This behavior is naturally implemented by ignoring `bump_left` and `bump_right`
  // in the falling state transitions above.
}

// Generate Verilog using the Chisel Driver (for testing/simulation purposes)
// Uncomment the lines below if generating Verilog:
/*
// object dutMain extends App {
//   chisel3.Driver.execute(args, () => new dut)
// }*/
