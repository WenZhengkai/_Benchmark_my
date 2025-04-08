import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val reset = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Task 1: Define FSM states
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, Fall = Value
  }
  val state = RegInit(State.WalkLeft)
  val preservedWalkingDirection = RegInit(State.WalkLeft)

  // Task 3: Handle reset functionality
  when(io.reset) {
    state := State.WalkLeft
    preservedWalkingDirection := State.WalkLeft
  }

  // Task 7: Define state transition logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.Fall
        preservedWalkingDirection := State.WalkLeft
      }.elsewhen(io.bump_left && io.bump_right) {
        state := State.WalkRight
      }.elsewhen(io.bump_left) {
        state := State.WalkRight
      }
    }
    is(State.WalkRight) {
      when(!io.ground) {
        state := State.Fall
        preservedWalkingDirection := State.WalkRight
      }.elsewhen(io.bump_left && io.bump_right) {
        state := State.WalkLeft
      }.elsewhen(io.bump_right) {
        state := State.WalkLeft
      }
    }
    is(State.Fall) {
      when(io.ground) {
        state := preservedWalkingDirection
      }
    }
  }

  // Task 6: Define output logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.Fall)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
