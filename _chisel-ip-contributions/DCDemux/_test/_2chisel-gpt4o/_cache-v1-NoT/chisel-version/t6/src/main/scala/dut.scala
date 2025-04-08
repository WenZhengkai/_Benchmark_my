// Import necessary Chisel libraries
import chisel3._
import chisel3.util._

/** 
 * DCDemux: A demultiplexer hardware design in Chisel that distributes tokens 
 * from a single input channel to one of multiple output channels based on a selector signal.
 * 
 * @param data The data type of incoming and outgoing data.
 * @param n The number of output channels.
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "The number of output channels (n) must be greater than 0.")

  // Log2Ceil to determine the bit-width of the selector signal
  val selWidth: Int = log2Ceil(n)

  // IO Declaration
  val io = IO(new Bundle {
    val sel = Input(UInt(selWidth.W))              // Selector signal
    val c = Flipped(DecoupledIO(data))             // Input channel
    val p = Vec(n, DecoupledIO(data))              // Output channels
  })

  // Default Initialization Logic
  io.c.ready := false.B // Input channel not ready by default

  // Iterate through all output channels
  for (i <- 0 until n) {
    // Default values for each output channel
    io.p(i).valid := false.B       // By default, output channel is not valid
    io.p(i).bits := io.c.bits      // Forward input data to every output channel

    // Selection Logic
    when(i.U === io.sel) {         // Active channel based on sel
      io.p(i).valid := io.c.valid  // Forward validity from input channel
      io.c.ready := io.p(i).ready  // Forward readiness to input channel
    }
  }
}
