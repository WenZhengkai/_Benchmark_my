// Import Chisel library
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())   // Left obstacle input
    val bump_right = Input(Bool())  // Right obstacle input
    val ground = Input(Bool())      // Ground signal input
    val walk_left = Output(Bool())  // Walking left signal
    val walk_right = Output(Bool()) // Walking right signal
    val aaah = Output(Bool())       // Falling signal
  })

  // State encoding for FSM
  val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)

  // State register to hold the current state of the FSM
  val state = RegInit(sWalkLeft)

  // Default output assignments
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State machine logic
  switch(state) {
    is(sWalkLeft) {
      when(!io.ground) { // Falling when no ground
        state := sFallLeft
        io.aaah := true.B
      }.elsewhen(io.bump_left) { // Bumped left, switch to walk right
        state := sWalkRight
      }.otherwise { // Continue walking left
        io.walk_left := true.B
      }
    }

    is(sWalkRight) {
      when(!io.ground) { // Falling when no ground
        state := sFallRight
        io.aaah := true.B
      }.elsewhen(io.bump_right) { // Bumped right, switch to walk left
        state := sWalkLeft
      }.otherwise { // Continue walking right
        io.walk_right := true.B
      }
    }

    is(sFallLeft) {
      when(io.ground) { // Land on the ground, resume walking left
        state := sWalkLeft
        io.walk_left := true.B
      }.otherwise { // Continue falling
        io.aaah := true.B
      }
    }

    is(sFallRight) {
      when(io.ground) { // Land on the ground, resume walking right
        state := sWalkRight
        io.walk_right := true.B
      }.otherwise { // Continue falling
        io.aaah := true.B
      }
    }
  }
}

