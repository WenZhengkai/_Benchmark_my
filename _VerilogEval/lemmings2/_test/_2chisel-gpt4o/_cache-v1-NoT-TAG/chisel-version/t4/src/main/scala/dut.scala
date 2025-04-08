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
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }
  val state = RegInit(State.WalkLeft) // Asynchronous reset to WalkLeft

  // Task 2 & 3: State Transition Logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.FallLeft // Transition to FallLeft if ground is 0
      }.elsewhen(io.bump_left) {
        state := State.WalkRight // Transition to WalkRight if bump_left is true
      }
    }
    is(State.WalkRight) {
      when(!io.ground) {
        state := State.FallRight // Transition to FallRight if ground is 0
      }.elsewhen(io.bump_right) {
        state := State.WalkLeft // Transition to WalkLeft if bump_right is true
      }
    }
    is(State.FallLeft) {
      when(io.ground) {
        state := State.WalkLeft // Transition to WalkLeft if ground is 1
      }
    }
    is(State.FallRight) {
      when(io.ground) {
        state := State.WalkRight // Transition to WalkRight if ground is 1
      }
    }
  }

  // Task 4: Output Logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft || state === State.FallRight)

  // Task 5 (Edge Cases): Handled implicitly by state transitions above
  // - In falling states (FallLeft, FallRight), `bump_left` and `bump_right` are ignored.
  // - Transitioning between walking and falling appropriately ignores bumps on the same cycle,
  //   since only the `ground` condition impacts the change in state during those cases.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
