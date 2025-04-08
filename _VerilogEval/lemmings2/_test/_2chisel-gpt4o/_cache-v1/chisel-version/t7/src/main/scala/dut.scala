import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())  // Input: bump at the left
    val bump_right = Input(Bool()) // Input: bump at the right
    val ground = Input(Bool())    // Input: ground presence
    val walk_left = Output(Bool())// Output: walking left signal
    val walk_right = Output(Bool())// Output: walking right signal
    val aaah = Output(Bool())     // Output: falling (exclaiming 'aaah')
  })

  // Define the states of the FSM
  object State extends ChiselEnum {
    val WalkLeft, WalkRight, FallLeft, FallRight = Value
  }

  // State register using a RegInit (reset state is WalkLeft)
  val state = RegInit(State.WalkLeft)

  // Default output values
  io.walk_left := false.B
  io.walk_right := false.B
  io.aaah := false.B

  // Update state and outputs based on the current state and input conditions
  switch(state) {
    is(State.WalkLeft) {
      when(!io.ground) {
        // Falling triggered when there's no ground
        state := State.FallLeft
      } .elsewhen(io.bump_left) {
        // Switch direction when bumped on the left
        state := State.WalkRight
      } .otherwise {
        // Continue walking left
        io.walk_left := true.B
      }
    }
    is(State.WalkRight) {
      when(!io.ground) {
        // Falling triggered when there's no ground
        state := State.FallRight
      } .elsewhen(io.bump_right) {
        // Switch direction when bumped on the right
        state := State.WalkLeft
      } .otherwise {
        // Continue walking right
        io.walk_right := true.B
      }
    }
    is(State.FallLeft) {
      // Exclaiming 'aaah' during fall
      io.aaah := true.B
      when(io.ground) {
        // Return to walking left when ground reappears
        state := State.WalkLeft
      }
    }
    is(State.FallRight) {
      // Exclaiming 'aaah' during fall
      io.aaah := true.B
      when(io.ground) {
        // Return to walking right when ground reappears
        state := State.WalkRight
      }
    }
  }
}
