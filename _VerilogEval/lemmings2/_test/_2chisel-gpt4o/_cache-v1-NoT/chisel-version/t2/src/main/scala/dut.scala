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

  // Task 1: Define States
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, Fall = Value
  }
  val state = RegInit(State.WalkLeft)
  val preservedDirection = RegInit(State.WalkLeft) // To preserve the direction during a `Fall`

  // Task 2: Default Output Values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // Task 3: Reset Functionality
  when(io.reset) {
    state := State.WalkLeft
    preservedDirection := State.WalkLeft
  } .otherwise {
    // Task 7: State Transition Logic
    switch(state) {
      is(State.WalkLeft) {
        when(!io.ground) {
          state := State.Fall
          preservedDirection := State.WalkLeft
        } .elsewhen(io.bump_right) {
          state := State.WalkRight
        }
      }
      is(State.WalkRight) {
        when(!io.ground) {
          state := State.Fall
          preservedDirection := State.WalkRight
        } .elsewhen(io.bump_left) {
          state := State.WalkLeft
        }
      }
      is(State.Fall) {
        when(io.ground) {
          state := preservedDirection
        }
      }
    }
  }

  // Task 6: Output Logic
  switch(state) {
    is(State.WalkLeft) {
      io.walk_left := true.B
    }
    is(State.WalkRight) {
      io.walk_right := true.B
    }
    is(State.Fall) {
      io.aaah := true.B
    }
  }
}

// Generate Verilog
/*
object dutMain extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
