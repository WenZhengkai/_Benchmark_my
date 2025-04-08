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
  val prevState = RegInit(State.WalkLeft) // Preserved state for remembering walk direction during Fall

  // Task 3: Reset functionality
  // Set initial state and outputs to default with reset
  when(io.reset) {
    state := State.WalkLeft
    prevState := State.WalkLeft
  }

  // Task 5: Handle falling behavior
  when(!io.ground) {
    prevState := state // Remember the walking state
    state := State.Fall
  } .elsewhen(state === State.Fall && io.ground) {
    // Return to walking state when back on the ground, based on preserved direction
    state := prevState
  }

  // Task 4: Handle bump transitions
  when(io.ground && state === State.WalkLeft && io.bump_left) {
    state := State.WalkRight
  } .elsewhen(io.ground && state === State.WalkRight && io.bump_right) {
    state := State.WalkLeft
  } .elsewhen(io.ground && io.bump_left && io.bump_right) {
    // If both bump_left and bump_right are high, toggle the direction
    when(state === State.WalkLeft) {
      state := State.WalkRight
    } .elsewhen(state === State.WalkRight) {
      state := State.WalkLeft
    }
  }

  // Task 6: Output logic
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.Fall)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
