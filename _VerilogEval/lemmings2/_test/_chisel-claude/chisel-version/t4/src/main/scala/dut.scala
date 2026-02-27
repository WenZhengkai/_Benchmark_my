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

  // States definition
  object State extends ChiselEnum {
    val WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT = Value
  }
  import State._

  // State register with async reset to WALK_LEFT
  val state = RegInit(WALK_LEFT)
  
  // State transition logic
  switch (state) {
    is (WALK_LEFT) {
      when (!io.ground) {
        state := FALL_LEFT
      }.elsewhen (io.bump_left) {
        state := WALK_RIGHT
      }
    }
    
    is (WALK_RIGHT) {
      when (!io.ground) {
        state := FALL_RIGHT
      }.elsewhen (io.bump_right) {
        state := WALK_LEFT
      }
    }
    
    is (FALL_LEFT) {
      when (io.ground) {
        state := WALK_LEFT
      }
    }
    
    is (FALL_RIGHT) {
      when (io.ground) {
        state := WALK_RIGHT
      }
    }
  }
  
  // Output logic (Moore machine)
  io.walk_left := (state === WALK_LEFT)
  io.walk_right := (state === WALK_RIGHT)
  io.aaah := (state === FALL_LEFT || state === FALL_RIGHT)
}
