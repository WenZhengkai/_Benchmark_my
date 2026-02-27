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
    val WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT = Value
  }
  
  // State register with asynchronous reset to WALK_LEFT
  val state = RegInit(State.WALK_LEFT)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // State machine transitions
  switch(state) {
    is(State.WALK_LEFT) {
      io.walk_left := true.B
      
      when(!io.ground) {
        state := State.FALL_LEFT
      }.elsewhen(io.bump_left) {
        state := State.WALK_RIGHT
      }
    }
    
    is(State.WALK_RIGHT) {
      io.walk_right := true.B
      
      when(!io.ground) {
        state := State.FALL_RIGHT
      }.elsewhen(io.bump_right) {
        state := State.WALK_LEFT
      }
    }
    
    is(State.FALL_LEFT) {
      io.aaah := true.B
      
      when(io.ground) {
        state := State.WALK_LEFT
      }
    }
    
    is(State.FALL_RIGHT) {
      io.aaah := true.B
      
      when(io.ground) {
        state := State.WALK_RIGHT
      }
    }
  }
}
