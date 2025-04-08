import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // 3-bit input vector representing requests
    val g = Output(UInt(3.W)) // 3-bit output vector representing grants
  })

  // Define the states
  val sA :: sB :: sC :: sD :: Nil = Enum(4) // State A = 0, B = 1, C = 2, D = 3
  val state = RegInit(sA) // The current state register, initialized to A

  // Default output values
  io.g := 0.U // All grants are deasserted by default

  // State Transition Logic
  switch(state) {
    is(sA) { // State A
      when(io.r(0)) { // r[0] = 1 (highest priority)
        state := sB
      } .elsewhen(io.r(1)) { // r[1] = 1 (next priority)
        state := sC
      } .elsewhen(io.r(2)) { // r[2] = 1 (lowest priority)
        state := sD
      }
    }
    is(sB) { // State B (Grant g[0] = 1)
      when(!io.r(0)) { // If r[0] = 0, return to state A
        state := sA
      }
    }
    is(sC) { // State C (Grant g[1] = 1)
      when(!io.r(1)) { // If r[1] = 0, return to state A
        state := sA
      }
    }
    is(sD) { // State D (Grant g[2] = 1)
      when(!io.r(2)) { // If r[2] = 0, return to state A
        state := sA
      }
    }
  }

  // Output Logic (Grant Signal)
  switch(state) {
    is(sB) { // State B corresponds to granting g[0] = 1
      io.g := "b001".U
    }
    is(sC) { // State C corresponds to granting g[1] = 1
      io.g := "b010".U
    }
    is(sD) { // State D corresponds to granting g[2] = 1
      io.g := "b100".U
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
