import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())   // Input: bump detected on the left
    val bump_right = Input(Bool()) // Input: bump detected on the right
    val ground = Input(Bool())     // Input: ground presence
    val walk_left = Output(Bool()) // Output: walking left state
    val walk_right = Output(Bool())// Output: walking right state
    val aaah = Output(Bool())      // Output: falling state
  })

  // Define states using an enumeration
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallingLeft, FallingRight = Value
  }

  // State register to hold the current state
  val state = RegInit(State.WalkLeft) // Default state: WalkLeft

  // Default outputs
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State transition logic
  switch(state) {
    is(State.WalkLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        state := State.FallingLeft // Falling while walking left
      }.elsewhen(io.bump_left || io.bump_right) {
        state := State.WalkRight // Switch to WalkRight if bumped
      }
    }
    is(State.WalkRight) {
      io.walk_right := true.B
      when(!io.ground) {
        state := State.FallingRight // Falling while walking right
      }.elsewhen(io.bump_left || io.bump_right) {
        state := State.WalkLeft // Switch to WalkLeft if bumped
      }
    }
    is(State.FallingLeft) {
      io.aaah := true.B // Falling state: say "aaah!"
      when(io.ground) {
        state := State.WalkLeft // Resume walking left when ground reappears
      }
    }
    is(State.FallingRight) {
      io.aaah := true.B // Falling state: say "aaah!"
      when(io.ground) {
        state := State.WalkRight // Resume walking right when ground reappears
      }
    }
  }
}

