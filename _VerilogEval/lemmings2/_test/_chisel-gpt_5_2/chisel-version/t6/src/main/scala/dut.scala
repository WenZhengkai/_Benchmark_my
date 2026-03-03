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

  // Moore FSM states
  val sWalkL :: sWalkR :: sFallL :: sFallR :: Nil = Enum(4)

  // Positive-edge triggered, asynchronous active-high reset to walk left
  val state = withReset(reset.asAsyncReset) { RegInit(sWalkL) }

  switch(state) {
    is(sWalkL) {
      when(!io.ground) {
        // Ground disappears: start falling; bumps this cycle do not affect direction
        state := sFallL
      }.elsewhen(io.bump_left || io.bump_right) {
        // Bumped while walking: switch direction (both bumps still switches)
        state := sWalkR
      }.otherwise {
        state := sWalkL
      }
    }

    is(sWalkR) {
      when(!io.ground) {
        state := sFallR
      }.elsewhen(io.bump_left || io.bump_right) {
        state := sWalkL
      }.otherwise {
        state := sWalkR
      }
    }

    is(sFallL) {
      when(io.ground) {
        // Ground reappears: resume prior direction; bumps this cycle do not affect direction
        state := sWalkL
      }.otherwise {
        // While falling, bumps do not affect direction
        state := sFallL
      }
    }

    is(sFallR) {
      when(io.ground) {
        state := sWalkR
      }.otherwise {
        state := sFallR
      }
    }
  }

  // Moore outputs
  io.walk_left  := (state === sWalkL)
  io.walk_right := (state === sWalkR)
  io.aaah       := (state === sFallL) || (state === sFallR)
}
