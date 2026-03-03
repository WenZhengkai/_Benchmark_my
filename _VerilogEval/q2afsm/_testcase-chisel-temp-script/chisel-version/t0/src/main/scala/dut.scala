import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // Force Bool reset for synchronous-reset style registers.
  val state = withClockAndReset(clock, reset.asBool) {
    val sA :: sB :: sC :: sD :: Nil = Enum(4)
    val st = RegInit(sA)

    switch(st) {
      is(sA) {
        when(io.r(0))      { st := sB } // highest priority
          .elsewhen(io.r(1)){ st := sC }
          .elsewhen(io.r(2)){ st := sD }
          .otherwise       { st := sA }
      }
      is(sB) { st := Mux(io.r(0), sB, sA) }
      is(sC) { st := Mux(io.r(1), sC, sA) }
      is(sD) { st := Mux(io.r(2), sD, sA) }
    }

    st
  }

  val sA :: sB :: sC :: sD :: Nil = Enum(4) // local decode constants
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g0 = 1
    is(sC) { io.g := "b010".U } // g1 = 1
    is(sD) { io.g := "b100".U } // g2 = 1
  }
}
