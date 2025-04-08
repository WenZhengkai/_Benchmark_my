import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left  = Input(Bool())
    val bump_right = Input(Bool())
    val ground     = Input(Bool())
    val walk_left  = Output(Bool())
    val walk_right = Output(Bool())
    val aaah       = Output(Bool())
  })

  // States Definition
  val sWalkLeft  :: sWalkRight :: sFallingLeft :: sFallingRight :: Nil = Enum(4)

  // State Register
  val state = RegInit(sWalkLeft)

  // Output Defaults
  io.walk_left  := false.B
  io.walk_right := false.B
  io.aaah       := false.B

  // State Machine Logic
  switch(state) {
    is(sWalkLeft) {
      io.walk_left := true.B
      when(!io.ground) {
        state := sFallingLeft
      }.elsewhen(io.bump_left || io.bump_right) {
        state := sWalkRight
      }
    }

    is(sWalkRight) {
      io.walk_right := true.B
      when(!io.ground) {
        state := sFallingRight
      }.elsewhen(io.bump_left || io.bump_right) {
        state := sWalkLeft
      }
    }

    is(sFallingLeft) {
      io.aaah := true.B
      when(io.ground) {
        state := sWalkLeft
      }
    }

    is(sFallingRight) {
      io.aaah := true.B
      when(io.ground) {
        state := sWalkRight
      }
    }
  }
}

