

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
  * DCCrossbar: A parameterizable hardware module for interconnecting M inputs to N outputs, 
  * ensuring non-blocking communication using DCDemux and DCArbiter components.
  *
  * @param data   Generic data type for input/output data interfaces
  * @param inputs Number of input ports
  * @param outputs Number of output ports
  */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // Single Input/Single Output Optimization
  if (inputs == 1 && outputs == 1) {
    io.p.head <> io.c.head
  } else {
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data, outputs)))
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect inputs to corresponding demultiplexers
    for (i <- 0 until inputs) {
      demuxes(i).io.sel := io.sel(i)
      demuxes(i).io.c <> io.c(i)
    }

    // Connect demux outputs to arbiter inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)
      }
    }

    // Connect arbiter outputs to crossbar outputs
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).io.p
    }
  }
}
