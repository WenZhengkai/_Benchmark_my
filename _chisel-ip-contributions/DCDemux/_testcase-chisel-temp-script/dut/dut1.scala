import chisel3._
import chisel3.util._

/** dut: A demultiplexer that distributes data from one input channel
  * to multiple output channels based on a selection signal.
  *
  * @param data The data type of the input and output channels.
  * @param n    The number of output channels.
  */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 1, "Number of output channels (n) must be greater than 1.")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))           // Selector signal
    val c = Flipped(Decoupled(data))              // Input channel
    val p = Vec(n, Decoupled(data))               // Output channels
  })

  // Task 1: Initialize the input ready signal
  io.c.ready := false.B // Set default value for input's ready signal

  // Task 2: Connect input data to all output channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits // All output channels share the input data
  }

  // Task 3: Conditionally set valid signals and update input ready signal
  for (i <- 0 until n) {
    when(io.sel === i.U) {
      io.p(i).valid := io.c.valid   // Propagate input validity to selected output
      io.c.ready := io.p(i).ready  // Input ready depends on selected output ready
    }.otherwise {
      io.p(i).valid := false.B      // Other outputs are invalid
    }
  }
}

