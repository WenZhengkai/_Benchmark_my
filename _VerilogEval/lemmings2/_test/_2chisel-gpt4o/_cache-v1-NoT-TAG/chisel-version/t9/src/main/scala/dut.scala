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

  // State register with reset to WalkLeft
  val state = RegInit(State.WalkLeft)

  // Task 2 & Task 3: State Transitions
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) { // If no ground, fall
        state := State.FallLeft
      }.elsewhen(io.bump_left) { // If bump left, switch direction
        state := State.WalkRight
      }
    }

    is(State.WalkRight) {
      when(!io.ground) { // If no ground, fall
        state := State.FallRight
      }.elsewhen(io.bump_right) { // If bump right, switch direction
        state := State.WalkLeft
      }
    }

    is(State.FallLeft) {
      when(io.ground) { // If ground, start walking left
        state := State.WalkLeft
      }
    }

    is(State.FallRight) {
      when(io.ground) { // If ground, start walking right
        state := State.WalkRight
      }
    }
  }

  // Task 4: Output Logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft || state === State.FallRight)

  // Task 5: Edge Case Handling
  // Bumps are ignored in falling states as these transitions are handled by design
  // No additional logic needed for bumps during falling → walking or walking → falling
}

// Generate the Verilog
/*
object dutMain extends App {
  println(chisel3.Driver.emitVerilog(new dut))
}
*/
