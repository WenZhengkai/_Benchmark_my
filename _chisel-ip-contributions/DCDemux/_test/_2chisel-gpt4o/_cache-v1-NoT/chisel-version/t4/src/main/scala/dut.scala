import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "The number of output channels (n) must be greater than 0.")

  // Calculate the width of the selector signal
  val selWidth = log2Ceil(n)

  // IO definition
  val io = IO(new Bundle {
    val sel = Input(UInt(selWidth.W))            // Selector signal
    val c   = Flipped(DecoupledIO(data))         // Input channel (valid-ready handshake)
    val p   = Vec(n, DecoupledIO(data))          // Output channels (vector of DecoupledIO)
  })

  // Initialize the default value for the input channel `ready` signal
  io.c.ready := false.B

  // Iterate over all output channels
  for (i <- 0 until n) {
    // Default settings for each output channel
    io.p(i).bits := io.c.bits       // Data is forwarded to all channels
    io.p(i).valid := false.B        // Default to invalid for all channels

    when (i.U === io.sel) {
      // Activate the selected output channel
      io.p(i).valid := io.c.valid   // Valid signal propagates when selected
      io.c.ready := io.p(i).ready   // Back-pressure control (ready is propagated)
    }
  }
}


