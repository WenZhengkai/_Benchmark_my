import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())    // Input: Bump signal from the left
    val bump_right = Input(Bool())   // Input: Bump signal from the right
    val ground = Input(Bool())       // Input: Ground signal (1 = on ground, 0 = falling)
    val reset = Input(Bool())        // Input: Reset signal
    val walk_left = Output(Bool())   // Output: Walking left indicator
    val walk_right = Output(Bool())  // Output: Walking right indicator
    val aaah = Output(Bool())        // Output: Falling indicator
  })

  // FSM State Enumeration
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, Fall = Value
  }

  // State Register
  val state = RegInit(State.WalkLeft) // Default to WalkLeft on reset
  val preservedDirection = RegInit(State.WalkLeft) // Store the walking direction before falling

  // Reset Logic
  when(io.reset) {
    state := State.WalkLeft
    preservedDirection := State.WalkLeft
  }

  // State Transition Logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.Fall
        preservedDirection := State.WalkLeft // Preserve walking direction
      } .elsewhen(io.bump_left || (io.bump_left && io.bump_right)) {
        state := State.WalkRight
      }
    }

    is(State.WalkRight) {
      when(!io.ground) {
        state := State.Fall
        preservedDirection := State.WalkRight // Preserve walking direction
      } .elsewhen(io.bump_right || (io.bump_left && io.bump_right)) {
        state := State.WalkLeft
      }
    }

    is(State.Fall) {
      // Transition back to preserved walking direction when ground is regained
      when(io.ground) {
        state := preservedDirection
      }
    }
  }

  // Output Logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.Fall) // True only in Fall state
}

// Generate FIRRTL code and Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
