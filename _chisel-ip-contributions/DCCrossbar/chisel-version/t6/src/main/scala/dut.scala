

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
 * DCCrossbar
 *
 * A parameterizable crossbar implemented in Chisel, to connect M input ports with N output ports.
 *
 * @param data Generic data type for the module's input/output data interfaces.
 * @param inputs Number of input ports available in the crossbar.
 * @param outputs Number of output ports available in the crossbar.
 */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // Optimization for the case when both number of inputs and outputs is 1
  if (inputs == 1 && outputs == 1) {
    io.c(0) <> io.p(0)
  } else {
    // Create a sequence of DCDemux instances
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data, outputs)))

    // Connect input ports to demuxes
    for (i <- 0 until inputs) {
      demuxes(i).io.sel := io.sel(i)
      demuxes(i).io.c <> io.c(i)
    }

    // Create a sequence of DCArbiter instances
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, false)))

    // Interconnect demuxes and arbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        // Connect each demux output to the corresponding arbiter input
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)
      }
      // Connect the arbiter output to the respective crossbar output
      io.p(o) <> arbiters(o).io.p
    }
  }
}
