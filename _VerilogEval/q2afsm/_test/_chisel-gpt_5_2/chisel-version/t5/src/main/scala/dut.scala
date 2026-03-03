import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })

  // State encoding
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  val state = RegInit(sA) // synchronous reset to A

  // Default outputs
  io.g := 0.U

  // Output logic (Moore-style grants)
  switch(state) {
    is(sB) { io.g := "b001".U } // g0=1
    is(sC) { io.g := "b010".U } // g1=1
    is(sD) { io.g := "b100".U } // g2=1
  }

  // Next-state logic
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)

  switch(state) {
    is(sA) {
      when(r0)       { state := sB }
        .elsewhen(r1){ state := sC }
        .elsewhen(r2){ state := sD }
        .otherwise   { state := sA }
    }
    is(sB) {
      when(r0) { state := sB } .otherwise { state := sA }
    }
    is(sC) {
      when(r1) { state := sC } .otherwise { state := sA }
    }
    is(sD) {
      when(r2) { state := sD } .otherwise { state := sA }
    }
  }
}
