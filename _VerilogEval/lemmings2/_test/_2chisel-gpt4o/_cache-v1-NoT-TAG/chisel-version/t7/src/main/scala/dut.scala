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

  // Task 1: Define states using an Enum
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // State register with asynchronous reset to WalkLeft
  val state = RegInit(State.WalkLeft)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // Task 2 & 3: State transition logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) { // Ground missing, falling
        state := State.FallLeft
      }.elsewhen(io.bump_left) { // Bumped into an obstacle, switch direction
        state := State.WalkRight
      }
      // By default, stay in WalkLeft
    }
    is(State.WalkRight) {
      when(!io.ground) { // Ground missing, falling
        state := State.FallRight
      }.elsewhen(io.bump_right) { // Bumped into an obstacle, switch direction
        state := State.WalkLeft
      }
      // By default, stay in WalkRight
    }
    is(State.FallLeft) {
      when(io.ground) { // Ground regained, start walking left
        state := State.WalkLeft
      }
      // By default, remain in FallLeft
    }
    is(State.FallRight) {
      when(io.ground) { // Ground regained, start walking right
        state := State.WalkRight
      }
      // By default, remain in FallRight
    }
  }

  // Task 4: Output logic
  switch(state) {
    is(State.WalkLeft) {
      io.walk_left := true.B
    }
    is(State.WalkRight) {
      io.walk_right := true.B
    }
    is(State.FallLeft) {
      io.aaah := true.B
    }
    is(State.FallRight) {
      io.aaah := true.B
    }
  }

  // Task 5: Edge case handling is inherently covered as bumps have no effect
  // in falling states, and transitions between walk ↔ fall happen exclusively
  // based on the `ground` signal.
}

/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
