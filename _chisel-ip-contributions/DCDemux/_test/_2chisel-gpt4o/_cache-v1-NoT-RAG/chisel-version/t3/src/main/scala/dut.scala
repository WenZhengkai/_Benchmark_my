import chisel3._
import chisel3.util._

/**
 * dut: A demultiplexer module that distributes input data from a single channel
 * to multiple output channels based on a selection signal `sel`.
 * 
 * @param data Data type of the input and output channels.
 * @param n Number of output channels.
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))            // Selector signal for choosing the output channel
    val c = Flipped(Decoupled(data))               // Input channel
    val p = Vec(n, Decoupled(data))                // Output channels (vector of Decoupled interfaces)
  })

  // Task 1: Initialize Input Ready Signal
  // Set the default value of the input's ready signal to 0.U
  io.c.ready := false.B

  // Task 2: Connect Input Data to All Output Channels
  // Iterate over all output channels and assign the input data to their bits field
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits // Route the input data to each output channel
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  // Control the valid signals of outputs and update the input's ready signal based on `sel`
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      // When the current channel is selected
      io.p(i).valid := io.c.valid // Propagate the input's valid signal
      io.c.ready := io.p(i).ready // Connect the input's ready signal to the selected output's ready signal
    }.otherwise {
      // For unselected channels
      io.p(i).valid := false.B // Disable the valid signal
    }
  }
}

