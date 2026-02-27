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
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // State register
  val state = RegInit(State.WalkLeft)

  // Next state logic
  val nextState = Wire(State())
  nextState := state

  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        nextState := State.FallLeft
      }.elsewhen(io.bump_left) {
        nextState := State.WalkRight
      }
    }
    is(State.WalkRight) {
      when(!io.ground) {
        nextState := State.FallRight
      }.elsewhen(io.bump_right) {
        nextState := State.WalkLeft
      }
    }
    is(State.FallLeft) {
      when(io.ground) {
        nextState := State.WalkLeft
      }
    }
    is(State.FallRight) {
      when(io.ground) {
        nextState := State.WalkRight
      }
    }
  }

  // Update state
  state := nextState

  // Output logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft || state === State.FallRight)

  // Asynchronous reset
  when(reset.asBool) {
    state := State.WalkLeft
  }
}