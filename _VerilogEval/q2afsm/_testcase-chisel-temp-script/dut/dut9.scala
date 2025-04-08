import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input request signals (r[2], r[1], r[0])
    val g = Output(UInt(3.W)) // 3-bit output grant signals (g[2], g[1], g[0])
  })

  // Define FSM states
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // Current state and next state registers
  val state = RegInit(sA) // Initialize to state A on reset

  // Default output (no grant given by default)
  io.g := 0.U

  // State transition logic
  switch(state) {
    is(sA) {
      // State A: No grants, decide based on priority
      when(io.r(0)) {
        state := sB // If r[0] is 1, grant to device 0
      } .elsewhen(io.r(1)) {
        state := sC // If r[1] is 1, grant to device 1
      } .elsewhen(io.r(2)) {
        state := sD // If r[2] is 1, grant to device 2
      }
    }

    is(sB) {
      // State B: Grant to device 0
      io.g := "b001".U // g[0] set to 1
      when(!io.r(0)) {
        state := sA // Go back to state A if device 0's request is released
      }
    }

    is(sC) {
      // State C: Grant to device 1
      io.g := "b001".U // g[1] set to 1
      when(!io.r(1)) {
        state := sA // Go back to state A if device 1's request is released
      }
    }

    is(sD) {
      // State D: Grant to device 2
      io.g := "b100".U // g[2] set to 1
      when(!io.r(2)) {
        state := sA // Go back to state A if device 2's request is released
      }
    }
  }
}

// Define the object to generate the Verilog
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
