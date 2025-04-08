import chisel3._
import chisel3.util._

/**
  * dut Module
  * A configurable demultiplexer that routes input data to one of the output channels
  * based on a selector signal, following a valid-ready handshake.
  *
  * @param data Type of the data being transmitted across the channels.
  * @param n    Number of output channels.
  */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0.")
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))            // Selector signal
    val c   = Flipped(Decoupled(data))             // Input channel
    val p   = Vec(n, Decoupled(data))              // Output channels
  })

  // Task 1: Initialize Input Ready Signal
  // Default: input channel is not ready until a matching output is available
  io.c.ready := false.B

  // Task 2: Connect Input Data to All Output Channels
  // Assign the input data (`c.bits`) to all output channels' `bits`
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      // When the current output is selected:
      io.p(i).valid := io.c.valid       // Propagate input `valid` to selected output
      io.c.ready := io.p(i).ready      // Set input `ready` based on selected output's readiness
    }.otherwise {
      // For all other outputs:
      io.p(i).valid := false.B         // Unselected outputs are invalid
    }
  }
}

