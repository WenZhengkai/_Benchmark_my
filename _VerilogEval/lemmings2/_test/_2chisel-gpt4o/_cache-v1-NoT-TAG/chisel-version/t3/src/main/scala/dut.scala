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

  // Task 2: Walking State Transitions
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        state := State.FallLeft
      } .elsewhen(io.bump_left) {
        state := State.WalkRight
      }
    }
    is(State.WalkRight) {
      when(!io.ground) {
        state := State.FallRight
      } .elsewhen(io.bump_right) {
        state := State.WalkLeft
      }
    }

    // Task 3: Falling State Transitions
    is(State.FallLeft) {
      when(io.ground) {
        state := State.WalkLeft
      }
    }
    is(State.FallRight) {
      when(io.ground) {
        state := State.WalkRight
      }
    }
  }

  // Task 4: Output Logic
  // Outputs are combinational based on current state.
  io.walk_left := (state === State.WalkLeft)
  io.walk_right := (state === State.WalkRight)
  io.aaah := (state === State.FallLeft) || (state === State.FallRight)
}

/*
object dut extends App {
  // Emit Verilog code for the dut module.
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
