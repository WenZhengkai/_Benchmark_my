import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool()) // Input signal: bumped on the left
    val bump_right = Input(Bool()) // Input signal: bumped on the right
    val ground = Input(Bool()) // Input signal: ground present or not
    val walk_left = Output(Bool()) // Output signal: walking left
    val walk_right = Output(Bool()) // Output signal: walking right
    val aaah = Output(Bool()) // Output signal: falling
  })

  // State enum for the FSM
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  val stateReg = RegInit(State.WalkLeft) // Initialize state to WalkLeft on reset

  // Default outputs
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // FSM behavior
  switch(stateReg) {
    is(State.WalkLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        stateReg := State.FallLeft
      }.elsewhen(io.bump_left) {
        stateReg := State.WalkRight
      }
    }

    is(State.WalkRight) {
      io.walk_right := true.B
      when(!io.ground) {
        stateReg := State.FallRight
      }.elsewhen(io.bump_right) {
        stateReg := State.WalkLeft
      }
    }

    is(State.FallLeft) {
      io.aaah := true.B
      when(io.ground) {
        stateReg := State.WalkLeft
      }
    }

    is(State.FallRight) {
      io.aaah := true.B
      when(io.ground) {
        stateReg := State.WalkRight
      }
    }
  }
}


