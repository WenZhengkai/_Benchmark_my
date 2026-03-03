import chisel3._
import chisel3.util._
import chisel3.experimental.RequireAsyncReset
import chisel3.ChiselEnum

class dut extends Module with RequireAsyncReset {
  val io = IO(new Bundle {
    val bump_left  = Input(Bool())
    val bump_right = Input(Bool())
    val ground     = Input(Bool())
    val walk_left  = Output(Bool())
    val walk_right = Output(Bool())
    val aaah       = Output(Bool())
  })

  object State extends ChiselEnum {
    val walkLeft, walkRight, fallLeft, fallRight = Value
  }

  // Async reset initializes to walking left
  val state = RegInit(State.walkLeft)

  switch(state) {
    is(State.walkLeft) {
      when(!io.ground) {
        // Start falling; preserve current direction
        state := State.fallLeft
      }.elsewhen(io.bump_left) {
        state := State.walkRight
      }.otherwise {
        state := State.walkLeft
      }
    }

    is(State.walkRight) {
      when(!io.ground) {
        // Start falling; preserve current direction
        state := State.fallRight
      }.elsewhen(io.bump_right) {
        state := State.walkLeft
      }.otherwise {
        state := State.walkRight
      }
    }

    is(State.fallLeft) {
      when(io.ground) {
        // Ground reappears; resume previous direction
        state := State.walkLeft
      }.otherwise {
        state := State.fallLeft
      }
    }

    is(State.fallRight) {
      when(io.ground) {
        // Ground reappears; resume previous direction
        state := State.walkRight
      }.otherwise {
        state := State.fallRight
      }
    }
  }

  // Moore outputs
  io.walk_left  := (state === State.walkLeft)
  io.walk_right := (state === State.walkRight)
  io.aaah       := (state === State.fallLeft) || (state === State.fallRight)
}
