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

  val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)

  // Asynchronous reset to walking left
  val state = withReset(reset.asAsyncReset) { RegInit(sWalkLeft) }

  switch(state) {
    is(sWalkLeft) {
      when(!io.ground) {
        state := sFallLeft // ground disappears: start falling, ignore bumps
      }.elsewhen(io.bump_left) {
        state := sWalkRight
      }.otherwise {
        state := sWalkLeft
      }
    }

    is(sWalkRight) {
      when(!io.ground) {
        state := sFallRight // ground disappears: start falling, ignore bumps
      }.elsewhen(io.bump_right) {
        state := sWalkLeft
      }.otherwise {
        state := sWalkRight
      }
    }

    is(sFallLeft) {
      when(io.ground) {
        state := sWalkLeft // resume prior direction, ignore bumps on landing cycle
      }.otherwise {
        state := sFallLeft
      }
    }

    is(sFallRight) {
      when(io.ground) {
        state := sWalkRight // resume prior direction, ignore bumps on landing cycle
      }.otherwise {
        state := sFallRight
      }
    }
  }

  // Moore outputs
  io.walk_left  := (state === sWalkLeft)
  io.walk_right := (state === sWalkRight)
  io.aaah       := (state === sFallLeft) || (state === sFallRight)
}
