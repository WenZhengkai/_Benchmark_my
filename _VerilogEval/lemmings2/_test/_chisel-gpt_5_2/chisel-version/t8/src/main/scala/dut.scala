import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left   = Input(Bool())
    val bump_right  = Input(Bool())
    val ground      = Input(Bool())
    val walk_left   = Output(Bool())
    val walk_right  = Output(Bool())
    val aaah        = Output(Bool())
  })

  // Moore FSM states
  val sWalkL :: sWalkR :: sFallL :: sFallR :: Nil = Enum(4)

  // Async, active-high reset to walking left
  val state = withReset(reset.asAsyncReset) { RegInit(sWalkL) }

  switch(state) {
    is(sWalkL) {
      when(!io.ground) {
        // Start falling; ignore bumps in this cycle
        state := sFallL
      }.elsewhen(io.bump_left || io.bump_right) {
        // Bumped (either side or both) -> switch direction
        state := sWalkR
      }
    }

    is(sWalkR) {
      when(!io.ground) {
        // Start falling; ignore bumps in this cycle
        state := sFallR
      }.elsewhen(io.bump_left || io.bump_right) {
        // Bumped (either side or both) -> switch direction
        state := sWalkL
      }
    }

    is(sFallL) {
      // While falling, ignore bumps.
      // When ground returns, resume walking in same direction as before fall.
      when(io.ground) {
        state := sWalkL
      }
    }

    is(sFallR) {
      when(io.ground) {
        state := sWalkR
      }
    }
  }

  // Moore outputs
  io.walk_left  := (state === sWalkL)
  io.walk_right := (state === sWalkR)
  io.aaah       := (state === sFallL) || (state === sFallR)
}
