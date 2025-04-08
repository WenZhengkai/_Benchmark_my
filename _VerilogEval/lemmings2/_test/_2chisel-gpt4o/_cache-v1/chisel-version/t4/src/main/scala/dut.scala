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

  // Define states
  val walkingLeft :: walkingRight :: falling :: Nil = Enum(3)

  // State and next state registers
  val state = RegInit(walkingLeft)
  val savedWalkingDirection = RegInit(walkingLeft) // Saves direction before falling

  // Default outputs
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  switch(state) {
    is(walkingLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        state := falling
        savedWalkingDirection := walkingLeft
      }.elsewhen(io.bump_left || io.bump_right) { // Switch direction if bumped
        state := walkingRight
      }
    }

    is(walkingRight) {
      io.walk_right := true.B
      when(!io.ground) {
        state := falling
        savedWalkingDirection := walkingRight
      }.elsewhen(io.bump_left || io.bump_right) { // Switch direction if bumped
        state := walkingLeft
      }
    }

    is(falling) {
      io.aaah := true.B
      when(io.ground) { // Resume walking in the saved direction
        state := savedWalkingDirection
      }
      // While falling, bump does not affect behavior
    }
  }
}

