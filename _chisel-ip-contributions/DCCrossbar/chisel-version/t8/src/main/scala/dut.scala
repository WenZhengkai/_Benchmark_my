

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
  * Parameterizable Crossbar module with M input ports and N output ports.
  *
  * @param data   Generic data type for the input/output ports (e.g., UInt, Bundle, etc.)
  * @param inputs Number of input ports
  * @param outputs Number of output ports
  */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  require(inputs > 0 && outputs > 0, "Inputs and Outputs must be greater than 0!")
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  if (inputs == 1 && outputs == 1) {
    // Single input/output case optimization: Direct connection
    io.p(0) <> io.c(0)
  } else {
    // Demultiplexers for each input
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data, outputs)))
    for (i <- 0 until inputs) {
      // Connect input to each corresponding demux
      demuxes(i).io.sel := io.sel(i) // Selection signal for this input
      demuxes(i).io.c <> io.c(i)     // Input connection
    }

    // Arbiters for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))
    for (j <- 0 until outputs) {
      // Collect inputs for each arbiter from corresponding demux outputs
      for (i <- 0 until inputs) {
        arbiters(j).io.c(i) <> demuxes(i).io.p(j)
      }
      // Connect arbiter output to corresponding crossbar output
      io.p(j) <> arbiters(j).io.p
    }
  }
}

