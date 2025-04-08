import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())   // True when a bump is detected on the left
    val bump_right = Input(Bool()) // True when a bump is detected on the right
    val ground = Input(Bool())     // True if Lemming is on the ground
    val walk_left = Output(Bool()) // Output for walking left
    val walk_right = Output(Bool())// Output for walking right
    val aaah = Output(Bool())      // Output for falling
  })

  // Task 1: State Enumeration & Reset Implementation
  // Define the 4 states using Chisel Enum
  val (WalkLeft :: WalkRight :: FallLeft :: FallRight :: Nil) = Enum(4)
  val state = RegInit(WalkLeft) // State register with asynchronous reset to WalkLeft
  
  // Task 2, Task 3: State Transitions
  switch(state) {
    is(WalkLeft) {
      when(!io.ground) { // Falling condition based on ground
        state := FallLeft
      } .elsewhen(io.bump_left) { // Change direction if bump on left wall
        state := WalkRight
      }
    }
    is(WalkRight) {
      when(!io.ground) { // Falling condition based on ground
        state := FallRight
      } .elsewhen(io.bump_right) { // Change direction if bump on right wall
        state := WalkLeft
      }
    }
    is(FallLeft) {
      when(io.ground) { // Resume walking when back on ground
        state := WalkLeft
      }
    }
    is(FallRight) {
      when(io.ground) { // Resume walking when back on ground
        state := WalkRight
      }
    }
  }

  // Task 4: Output Logic
  // Moore FSM outputs are determined only by the current state
  io.walk_left := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah := (state === FallLeft || state === FallRight)

  // Task 5: Edge Case Handling
  // Bumps are ignored in falling states as the transitions are explicitly handled.
  // This is ensured by the state machine logic provided above.
}

/*
object dut extends App {
  // Generate the Verilog code for the dut module
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
