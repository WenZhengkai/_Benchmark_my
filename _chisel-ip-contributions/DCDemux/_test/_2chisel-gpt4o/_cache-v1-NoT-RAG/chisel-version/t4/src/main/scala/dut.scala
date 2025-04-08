import chisel3._
import chisel3.util._

/** 
 * dut: A demultiplexer module that routes input data to one of multiple output channels
 * based on a selector signal (`sel`), using the DecoupledIO handshake interface.
 * 
 * @param data The type of the data being demultiplexed.
 * @param n Number of output channels.
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W)) // Selector signal
    val c = Flipped(DecoupledIO(data))   // Input channel
    val p = Vec(n, DecoupledIO(data))    // Vector of output channels
  })

  // Task 1: Initialize Input Ready Signal
  io.c.ready := false.B // Default: input is not ready
  
  // Task 2: Connect Input Data to All Output Channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits // Route input data to all outputs
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when (i.U === io.sel) { // If the current output channel matches the selector
      io.p(i).valid := io.c.valid      // Propagate input validity to the selected output
      io.c.ready := io.p(i).ready      // Input is ready if the selected output is ready
    }.otherwise {
      io.p(i).valid := false.B         // Disable unselected output channels
    }
  }
}

