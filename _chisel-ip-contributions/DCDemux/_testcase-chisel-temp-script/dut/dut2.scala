import chisel3._
import chisel3.util._

/**
 * dut - A demultiplexing module that routes an input channel to one of multiple output channels based on a selector signal
 * @param data The data type for the input and output channels
 * @param n The number of output channels
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 1, "n (number of output channels) must be greater than 1")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))        // Selector signal
    val c = Flipped(Decoupled(data))           // Input channel
    val p = Vec(n, Decoupled(data))            // Output channels
  })

  // Task 1: Initialize Input Ready Signal
  io.c.ready := false.B

  // Task 2: Connect Input Data to All Output Channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits          // All outputs receive the input data
    io.p(i).valid := false.B           // Default valid signal for outputs is `false.B`
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when(i.U === io.sel) {             // Check if current channel matches the selector
      io.p(i).valid := io.c.valid      // Propagate input validity to the selected output
      io.c.ready := io.p(i).ready      // Input is ready if selected output is ready
    }
  }
}

