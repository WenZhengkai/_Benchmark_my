import chisel3._

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // States: A=idle, B=grant0, C=grant1, D=grant2
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  val state = RegInit(sA)

  // Next-state logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        state := sB
      }.elsewhen(io.r(1)) {
        state := sC
      }.elsewhen(io.r(2)) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    is(sB) {
      when(io.r(0)) { state := sB }
        .otherwise { state := sA }
    }
    is(sC) {
      when(io.r(1)) { state := sC }
        .otherwise { state := sA }
    }
    is(sD) {
      when(io.r(2)) { state := sD }
        .otherwise { state := sA }
    }
  }

  // Output logic (Moore outputs)
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g0 = 1
    is(sC) { io.g := "b010".U } // g1 = 1
    is(sD) { io.g := "b100".U } // g2 = 1
  }
}
