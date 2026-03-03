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

  // Asynchronous, active-high reset to walking left
  val state = withReset(reset.asAsyncReset) { RegInit(sWalkL) }

  switch(state) {
    is(sWalkL) {
      when(!io.ground) {
        // ground disappears -> start falling; ignore bumps this cycle
        state := sFallL
      }.elsewhen(io.bump_left || io.bump_right) {
        // bumped on either/both sides -> switch direction
        state := sWalkR
      }
    }

    is(sWalkR) {
      when(!io.ground) {
        // ground disappears -> start falling; ignore bumps this cycle
        state := sFallR
      }.elsewhen(io.bump_left || io.bump_right) {
        // bumped on either/both sides -> switch direction
        state := sWalkL
      }
    }

    is(sFallL) {
      // While falling, ignore bumps. When ground reappears, resume prior direction.
      when(io.ground) { state := sWalkL }
    }

    is(sFallR) {
      // While falling, ignore bumps. When ground reappears, resume prior direction.
      when(io.ground) { state := sWalkR }
    }
  }

  // Moore outputs (depend only on state)
  io.walk_left  := (state === sWalkL)
  io.walk_right := (state === sWalkR)
  io.aaah       := (state === sFallL) || (state === sFallR)
}
