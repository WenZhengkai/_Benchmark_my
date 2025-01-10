

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/** 
  * DCCrossbar
  * 
  * The DCCrossbar is a parameterizable hardware module implemented in Chisel,
  * designed to interconnect M input ports with N output ports. It facilitates
  * concurrent communication while ensuring non-blocking operations, leveraging
  * DCDemux and DCArbiter components.
  *
  * @param data Type of data carried by the crossbar
  * @param inputs Number of input ports
  * @param outputs Number of output ports
  */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  require(inputs > 0, "Number of inputs must be greater than 0")
  require(outputs > 0, "Number of outputs must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // Case 1: Single input and single output - Direct connection
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Case 2: General case with multiple inputs and outputs

    // Instantiate DCDemux for each input
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data, outputs)))

    // Instantiate DCArbiter for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect inputs to their respective demuxes
    for (i <- 0 until inputs) {
      demuxes(i).io.c <> io.c(i)                     // Connect incoming input to the demux
      demuxes(i).io.sel := io.sel(i)                 // Set selection signal for the demux
    }

    // Connect demux outputs to arbiter inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)    // Connect each demux output to the corresponding arbiter input
      }

      // Connect each arbiter output to the corresponding crossbar output
      io.p(o) <> arbiters(o).io.p
    }
  }
}

