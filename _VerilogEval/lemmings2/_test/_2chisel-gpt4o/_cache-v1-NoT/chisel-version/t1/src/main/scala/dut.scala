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
  // Enumerate the three states: WalkLeft, WalkRight, Fall
  object State extends Chisel.Enum {
    val WalkLeft, WalkRight, Fall = Value
  }
  
  val state = RegInit(State.WalkLeft)

  // Preserve the walking direction during the Fall state
  val direction = RegInit(State.WalkLeft)

  // Task 3: Implement reset functionality
  when(io.reset) {
    state := State.WalkLeft
    direction := State.WalkLeft
  }

  // Task 7: Define the state transition logic
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) { // Ground is 0 -> Fall
        state := State.Fall
        direction := State.WalkLeft
      } .elsewhen(io.bump_left || (io.bump_left && io.bump_right)) { // Bump left or both sides
        state := State.WalkRight
      }
    }
    is(State.WalkRight) {
      when(!io.ground) { // Ground is 0 -> Fall
        state := State.Fall
        direction := State.WalkRight
      } .elsewhen(io.bump_right || (io.bump_left && io.bump_right)) { // Bump right or both sides
        state := State.WalkLeft
      }
    }
    is(State.Fall) {
      when(io.ground) { // Ground is 1 -> Return to preserved direction
        state := direction
      }
    }
  }

  // Task 6: Implement output logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.Fall)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
