import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val reset = Input(Bool()) // Explicit reset signal
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Task 1: Define FSM states
  val WalkLeft :: WalkRight :: Fall :: Nil = Enum(3)

  // State and preserved direction registers
  val state = RegInit(WalkLeft) // Default state is WalkLeft
  val preservedDirection = RegInit(WalkLeft) // Used to preserve walking state

  // Task 3: Reset logic
  when(io.reset) {
    state := WalkLeft
    preservedDirection := WalkLeft
  }

  // Task 7: FSM transition logic
  switch(state) {
    is(WalkLeft) {
      when(!io.ground) {
        // Falling when no ground
        state := Fall
        preservedDirection := WalkLeft
      }.elsewhen(io.bump_left && io.bump_right) {
        // Both bumps: toggle direction (go right in this case)
        state := WalkRight
      }.elsewhen(io.bump_left) {
        // Bump left: switch to WalkRight
        state := WalkRight
      }
    }

    is(WalkRight) {
      when(!io.ground) {
        // Falling when no ground
        state := Fall
        preservedDirection := WalkRight
      }.elsewhen(io.bump_left && io.bump_right) {
        // Both bumps: toggle direction (go left in this case)
        state := WalkLeft
      }.elsewhen(io.bump_right) {
        // Bump right: switch to WalkLeft
        state := WalkLeft
      }
    }

    is(Fall) {
      when(io.ground) {
        // When ground becomes 1, resume preserved walking state
        state := preservedDirection
      }
    }
  }

  // Task 6: Output logic
  io.walk_left := (state === WalkLeft)
  io.walk_right := (state === WalkRight)
  io.aaah := (state === Fall)
}

// Generate the Verilog code (for testing purposes)
/*
object dutMain extends App {
  println("Generating Verilog for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
