import chisel3._
import chisel3.util._

/**
 * dut Module:
 * A demultiplexer module that distributes a single input channel across multiple output channels
 * based on the selector signal (`sel`). The module supports valid-ready handshake using DecoupledIO.
 *
 * @param data The Chisel Data type for the input and output data (e.g., UInt, Bundle, etc.).
 * @param n    The number of output channels.
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "The number of output channels (n) must be greater than 0.")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))      // Selection signal
    val c   = Flipped(Decoupled(data))       // Input channel
    val p   = Vec(n, Decoupled(data))        // Output channels
  })

  // Task 1: Initialize Input Ready Signal
  io.c.ready := false.B

  // Task 2: Connect Input Data to All Output Channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits               // Propagate input data to all output channels
    io.p(i).valid := false.B                // Default valid signal for each output is false
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when (i.U === io.sel) {                 // Check if the current output channel matches the selector
      io.p(i).valid := io.c.valid           // Enable valid propagation for the selected channel
      io.c.ready := io.p(i).ready           // Input readiness depends on the selected channel's readiness
    }
  }
}

