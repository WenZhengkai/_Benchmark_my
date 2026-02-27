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

  // Define the states
  object State extends ChiselEnum {
    val WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT = Value
  }
  import State._

  // State register with asynchronous reset to WALK_LEFT
  val state = RegInit(WALK_LEFT)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // Next state logic
  switch(state) {
    is(WALK_LEFT) {
      io.walk_left := true.B
      
      when(!io.ground) {
        state := FALL_LEFT
      }.elsewhen(io.bump_left) {
        state := WALK_RIGHT
      }
    }
    
    is(WALK_RIGHT) {
      io.walk_right := true.B
      
      when(!io.ground) {
        state := FALL_RIGHT
      }.elsewhen(io.bump_right) {
        state := WALK_LEFT
      }
    }
    
    is(FALL_LEFT) {
      io.aaah := true.B
      
      when(io.ground) {
        state := WALK_LEFT
      }
    }
    
    is(FALL_RIGHT) {
      io.aaah := true.B
      
      when(io.ground) {
        state := WALK_RIGHT
      }
    }
  }
}
