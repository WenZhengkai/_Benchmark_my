import chisel3._
import chisel3.util._

/** dut Module
  * Models a Lemming's movement using a finite state machine.
  *
  * States:
  * - WalkLeft: Lemming is walking left.
  * - WalkRight: Lemming is walking right.
  * - FallingLeft: Lemming is falling while it was walking left.
  * - FallingRight: Lemming is falling while it was walking right.
  *
  * Inputs:
  * - bump_left: 1 if an obstacle is on the left.
  * - bump_right: 1 if an obstacle is on the right.
  * - ground: 1 if there is ground under the Lemming.
  *
  * Outputs:
  * - walk_left: 1 if the Lemming is walking left.
  * - walk_right: 1 if the Lemming is walking right.
  * - aaah: 1 if the Lemming is falling.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // State encoding for FSM
  val WalkLeft :: WalkRight :: FallingLeft :: FallingRight :: Nil = Enum(4)
  val state = RegInit(WalkLeft) // Start in WalkLeft state

  // Transition logic
  switch(state) {
    is(WalkLeft) {
      when(!io.ground) {
        state := FallingLeft // Fall if there's no ground
      }.elsewhen(io.bump_left) {
        state := WalkRight // Switch to walking right
      }
    }

    is(WalkRight) {
      when(!io.ground) {
        state := FallingRight // Fall if there's no ground
      }.elsewhen(io.bump_right) {
        state := WalkLeft // Switch to walking left
      }
    }

    is(FallingLeft) {
      when(io.ground) {
        state := WalkLeft // Resume walking left when ground reappears
      }
    }

    is(FallingRight) {
      when(io.ground) {
        state := WalkRight // Resume walking right when ground reappears
      }
    }
  }

  // Output logic (Moore FSM - outputs depend only on the state)
  io.walk_left := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah := (state === FallingLeft || state === FallingRight)
}

