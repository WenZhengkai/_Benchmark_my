import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // r(0)=device0, r(1)=device1, r(2)=device2
    val g = Output(UInt(3.W)) // g(0), g(1), g(2)
  })

  // States: A (idle), B (grant 0), C (grant 1), D (grant 2)
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // Synchronous reset to state A
  val state = RegInit(sA)
  val nextState = WireDefault(state)

  // Next-state logic
  switch(state) {
    is(sA) {
      when(io.r(0)) {
        nextState := sB // highest priority
      }.elsewhen(io.r(1)) {
        nextState := sC
      }.elsewhen(io.r(2)) {
        nextState := sD
      }.otherwise {
        nextState := sA
      }
    }
    is(sB) {
      when(io.r(0)) { nextState := sB }
        .otherwise { nextState := sA }
    }
    is(sC) {
      when(io.r(1)) { nextState := sC }
        .otherwise { nextState := sA }
    }
    is(sD) {
      when(io.r(2)) { nextState := sD }
        .otherwise { nextState := sA }
    }
  }

  state := nextState

  // Output logic (Moore FSM)
  io.g := 0.U
  switch(state) {
    is(sB) { io.g := "b001".U } // g0=1
    is(sC) { io.g := "b010".U } // g1=1
    is(sD) { io.g := "b100".U } // g2=1
  }
}

// Optional: Verilog generation entry point
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
