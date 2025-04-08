import chisel3._
import chisel3.util._

/**
 * dut Module
 *
 * This module demultiplexes a single input stream into multiple output streams based on a selection signal.
 *
 * @param data The data type of the input and output streams.
 * @param n    The number of output channels.
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))        // Selection signal
    val c = Flipped(Decoupled(data))           // Input channel (DecoupledIO)
    val p = Vec(n, Decoupled(data))            // Output channels (Vec of DecoupledIO)
  })

  // Task 1: Initialize input ready signal
  io.c.ready := false.B  // By default, input is not ready to accept data

  // Task 2: Connect input data to all output channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits  // Route input data to all outputs
  }

  // Task 3: Conditionally set valid signals and update ready signal
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      io.p(i).valid := io.c.valid  // Enable the selected output's valid signal
      io.c.ready := io.p(i).ready // Input ready depends on the selected output's ready signal
    }.otherwise {
      io.p(i).valid := false.B    // Disable unselected outputs
    }
  }
}
