// Import necessary libraries
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())  // True if critter bumps into left wall
    val bump_right = Input(Bool()) // True if critter bumps into right wall
    val ground = Input(Bool())     // True if critter is on the ground
    val walk_left = Output(Bool()) // Output high when critter walks left
    val walk_right = Output(Bool()) // Output high when critter walks right
    val aaah = Output(Bool())      // Output high when critter is falling
  })

  // Define states using Chisel Enum
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // Define state register and initialize it to WalkLeft state
  val state = RegInit(State.WalkLeft)

  // Default outputs (Moore FSM: purely determined by state)
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State machine implementation
  switch(state) {

    // WalkLeft state
    is(State.WalkLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        state := State.FallLeft // Falling because no ground
      }.elsewhen(io.bump_left) {
        state := State.WalkRight // Bump into left wall, switch direction
      }
    }

    // WalkRight state
    is(State.WalkRight) {
      io.walk_right := true.B
      when(!io.ground) {
        state := State.FallRight // Falling because no ground
      }.elsewhen(io.bump_right) {
        state := State.WalkLeft // Bump into right wall, switch direction
      }
    }

    // FallLeft state
    is(State.FallLeft) {
      io.aaah := true.B
      when(io.ground) {
        state := State.WalkLeft // Back on the ground, start walking left
      }
    }

    // FallRight state
    is(State.FallRight) {
      io.aaah := true.B
      when(io.ground) {
        state := State.WalkRight // Back on the ground, start walking right
      }
    }
  }
}

// Main object to generate Verilog
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
