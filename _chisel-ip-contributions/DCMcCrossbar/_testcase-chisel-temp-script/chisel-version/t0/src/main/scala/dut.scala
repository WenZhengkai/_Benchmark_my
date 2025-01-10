import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W))) // Selection signals for each input
    val c = Vec(inputs, Flipped(Decoupled(data.cloneType))) // Input data channels
    val p = Vec(outputs, Decoupled(data.cloneType)) // Output data channels
  })

  if (inputs == 1 && outputs == 1) {
    // Optimization for a single input and output
    io.p(0) <> io.c(0)
  } else {
    // General case for multiple inputs and outputs

    // Create an array of DCMirror modules, one for each input
    val mirrors = Array.fill(inputs) { Module(new DCMirror(data, outputs)) }

    for (i <- 0 until inputs) {
      mirrors(i).io.dst := io.sel(i) // Connect selection signal to each mirror
      mirrors(i).io.c <> io.c(i) // Connect input data to each mirror

      for (j <- 0 until outputs) {
        // Connect each mirror output to the appropriate arbiter input
        mirrors(i).io.p(j) <> io.p(j)
      }
    }

    // Create an array of DCArbiter modules, one for each output
    val arbiters = Array.fill(outputs) { Module(new DCArbiter(data, inputs, locking = false)) }

    for (j <- 0 until outputs) {
      for (i <- 0 until inputs) {
        // Connect each mirror output to the appropriate arbiter input
        arbiters(j).io.c(i) <> mirrors(i).io.p(j)
      }

      // Connect the arbiter output to the crossbar output
      arbiters(j).io.p <> io.p(j)
    }
  }
}
