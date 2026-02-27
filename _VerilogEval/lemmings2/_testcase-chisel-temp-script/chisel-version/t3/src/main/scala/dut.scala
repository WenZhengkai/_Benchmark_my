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

  // Define state constants
  object State {
    val WALK_LEFT = 0.U(2.W)
    val WALK_RIGHT = 1.U(2.W)
    val FALL_LEFT = 2.U(2.W)
    val FALL_RIGHT = 3.U(2.W)
  }

  // State register with async reset to walk left
  val state = RegInit(State.WALK_LEFT)

  // Next state logic
  val nextState = Wire(UInt(2.W))
  nextState := state

  switch(state) {
    is(State.WALK_LEFT) {
      when(!io.ground) {
        nextState := State.FALL_LEFT
      }.elsewhen(io.bump_left) {
        nextState := State.WALK_RIGHT
      }
    }
    is(State.WALK_RIGHT) {
      when(!io.ground) {
        nextState := State.FALL_RIGHT
      }.elsewhen(io.bump_right) {
        nextState := State.WALK_LEFT
      }
    }
    is(State.FALL_LEFT) {
      when(io.ground) {
        nextState := State.WALK_LEFT
      }
    }
    is(State.FALL_RIGHT) {
      when(io.ground) {
        nextState := State.WALK_RIGHT
      }
    }
  }

  // State register update
  state := nextState

  // Output logic (Moore machine - outputs depend only on current state)
  io.walk_left := (state === State.WALK_LEFT)
  io.walk_right := (state === State.WALK_RIGHT)
  io.aaah := (state === State.FALL_LEFT || state === State.FALL_RIGHT)
}
