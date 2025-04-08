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
  object States extends ChiselEnum {
    val WalkLeft, WalkRight, Fall = Value
  }

  val state = RegInit(States.WalkLeft) // Default state: WalkLeft
  val preservedDirection = RegInit(false.B) // Preserved direction for fall case (0 = left, 1 = right)

  // Task 2: Define module I/O ports
  // Already handled by the IO definition above

  // Task 3: Reset functionality
  when(io.reset) {
    state := States.WalkLeft // Reset to default state WalkLeft
    preservedDirection := false.B
  }.otherwise {
    // Task 4, Task 5 & Task 7: FSM transition logic
    switch(state) {
      is(States.WalkLeft) {
        when(!io.ground) {
          state := States.Fall
          preservedDirection := false.B
        }.elsewhen(io.bump_left && io.bump_right) {
          state := States.WalkRight
        }.elsewhen(io.bump_left) {
          state := States.WalkRight
        }
      }
      is(States.WalkRight) {
        when(!io.ground) {
          state := States.Fall
          preservedDirection := true.B
        }.elsewhen(io.bump_left && io.bump_right) {
          state := States.WalkLeft
        }.elsewhen(io.bump_right) {
          state := States.WalkLeft
        }
      }
      is(States.Fall) {
        when(io.ground) {
          state := Mux(preservedDirection, States.WalkRight, States.WalkLeft)
        }
      }
    }
  }

  // Task 6: Implement output logic
  io.walk_left := (state === States.WalkLeft)
  io.walk_right := (state === States.WalkRight)
  io.aaah := (state === States.Fall)
}

/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
