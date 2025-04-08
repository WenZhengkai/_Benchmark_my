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
  val WalkLeft :: WalkRight :: Fall :: Nil = Enum(3)

  // State and direction registers
  val stateReg = RegInit(WalkLeft)

  // Task 3: Reset functionality
  when(io.reset) {
    stateReg := WalkLeft
  }

  // Intermediate variables to preserve walking direction when falling
  val preservedState = RegInit(WalkLeft)

  // Task 7: State transition logic
  switch(stateReg) {
    is(WalkLeft) {
      when(!io.ground) {
        stateReg := Fall
        preservedState := WalkLeft
      }.elsewhen(io.bump_left) {
        stateReg := WalkRight
      }
    }
    is(WalkRight) {
      when(!io.ground) {
        stateReg := Fall
        preservedState := WalkRight
      }.elsewhen(io.bump_right) {
        stateReg := WalkLeft
      }
    }
    is(Fall) {
      when(io.ground) {
        stateReg := preservedState
      }
    }
  }

  // Task 6: Output logic
  io.walk_left := stateReg === WalkLeft
  io.walk_right := stateReg === WalkRight
  io.aaah := stateReg === Fall
}

// Generate the Verilog
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
