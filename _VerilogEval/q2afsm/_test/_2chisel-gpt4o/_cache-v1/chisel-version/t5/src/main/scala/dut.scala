import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W)) // Input: Request signals (3 bits)
    val g = Output(UInt(3.W)) // Output: Grant signals (3 bits)
  })

  // States of the FSM
  val sA :: sB :: sC :: sD :: Nil = Enum(4)

  // State register
  val state = RegInit(sA)

  // Default output
  io.g := 0.U

  // State transition logic
  switch(state) {
    is(sA) {
      // Remain in state A if no requests are made
      when(io.r === 0.U) {
        state := sA
      }
        // Priority: Transition to B if r[0] = 1
      .elsewhen(io.r(0)) {
        state := sB
      }
        // Priority: Transition to C if r[1] = 1 and r[0] = 0
      .elsewhen(io.r(1)) {
        state := sC
      }
        // Priority: Transition to D if r[2] = 1 and r[0] = 0 and r[1] = 0
      .elsewhen(io.r(2)) {
        state := sD
      }
    }
    is(sB) {
      // Grant signal for device 0
      io.g := "b001".U
      // Stay in state B as long as r[0] is 1
      when(io.r(0)) {
        state := sB
      } .otherwise {
        state := sA
      }
    }
    is(sC) {
      // Grant signal for device 1
      io.g := "b010".U
      // Stay in state C as long as r[1] is 1
      when(io.r(1)) {
        state := sC
      } .otherwise {
        state := sA
      }
    }
    is(sD) {
      // Grant signal for device 2
      io.g := "b100".U
      // Stay in state D as long as r[2] is 1
      when(io.r(2)) {
        state := sD
      } .otherwise {
        state := sA
      }
    }
  }
}

/*
object dut extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
