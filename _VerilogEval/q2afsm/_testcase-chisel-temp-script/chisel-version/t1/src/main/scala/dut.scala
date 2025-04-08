import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit request signals (r[2], r[1], r[0])
    val g = Output(UInt(3.W)) // 3-bit grant signals (g[2], g[1], g[0])
  })

  // Define FSM states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // State register to hold the current state
  val state = RegInit(sA) // Start in state A

  // Default output for grant signals
  val g0 = WireDefault(false.B)
  val g1 = WireDefault(false.B)
  val g2 = WireDefault(false.B)

  // FSM state transition logic
  switch(state) {
    is(sA) {
      // State A: No grants -> Go to next state based on requests
      when(io.r(0) === 1.U) {
        state := sB
      }.elsewhen(io.r(1) === 1.U) {
        state := sC
      }.elsewhen(io.r(2) === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
    is(sB) {
      // State B: Device 0 granted (g0 = 1)
      g0 := true.B
      when(io.r(0) === 1.U) {
        state := sB
      }.otherwise {
        state := sA
      }
    }
    is(sC) {
      // State C: Device 1 granted (g1 = 1)
      g1 := true.B
      when(io.r(1) === 1.U) {
        state := sC
      }.otherwise {
        state := sA
      }
    }
    is(sD) {
      // State D: Device 2 granted (g2 = 1)
      g2 := true.B
      when(io.r(2) === 1.U) {
        state := sD
      }.otherwise {
        state := sA
      }
    }
  }

  // Pack grant signals into a single 3-bit output
  io.g := Cat(g2, g1, g0)
}

/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
