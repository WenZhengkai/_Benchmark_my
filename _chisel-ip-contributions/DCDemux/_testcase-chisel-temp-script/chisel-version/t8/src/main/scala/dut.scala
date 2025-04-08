import chisel3._
import chisel3.util._

/**
 * dut Module
 * @param data The data type of the input and output
 * @param n    The number of output channels
 */
class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0.")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W)) // Selection signal
    val c   = Flipped(DecoupledIO(data)) // Input channel
    val p   = Vec(n, DecoupledIO(data))  // Output channels
  })

  // Task 1: Initialize Input Ready Signal
  io.c.ready := false.B // Default: Input is not ready to accept data

  // Task 2: Connect Input Data to All Output Channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits // Route input data to all output channels
    io.p(i).valid := false.B  // Default: Disable output validity
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when(i.U === io.sel) { // Check if current output channel matches selection
      io.p(i).valid := io.c.valid    // Propagate input validity to the selected output
      io.c.ready := io.p(i).ready   // Input readiness depends on selected output's readiness
    } 
  }
}

