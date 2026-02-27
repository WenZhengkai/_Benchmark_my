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
  // Define the finite state machine states
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // Define the state register with reset value set to WalkLeft
  val state = RegInit(State.WalkLeft)

  // Task 2 & 3: Walking and Falling State Transitions
  // Next state logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) { // If no ground, start falling
        state := State.FallLeft
      }.elsewhen(io.bump_left) { // If bump_left is true, switch direction
        state := State.WalkRight
      }.otherwise {
        state := State.WalkLeft
      }
    }
    is(State.WalkRight) {
      when(!io.ground) { // If no ground, start falling
        state := State.FallRight
      }.elsewhen(io.bump_right) { // If bump_right is true, switch direction
        state := State.WalkLeft
      }.otherwise {
        state := State.WalkRight
      }
    }
    is(State.FallLeft) {
      when(io.ground) { // If ground is true, resume walking left
        state := State.WalkLeft
      }.otherwise {
        state := State.FallLeft // Continue falling
      }
    }
    is(State.FallRight) {
      when(io.ground) { // If ground is true, resume walking right
        state := State.WalkRight
      }.otherwise {
        state := State.FallRight // Continue falling
      }
    }
  }

  // Task 4: Output Logic
  // Outputs are assigned combinatorially based on the current state
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft || state === State.FallRight)
}

// Generate the Verilog for this module (if you want to verify it)
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
