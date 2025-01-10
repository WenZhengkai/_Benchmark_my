

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(Decoupled(data.cloneType)))
    val p = Vec(outputs, Decoupled(data.cloneType))
  })

  // Single Input/Output Optimization
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Multiple Inputs/Outputs - Use DCDemux and DCArbiter
    val demuxes = Seq.fill(inputs) {
      Module(new DCDemux(data, outputs))
    }

    val arbiters = Seq.fill(outputs) {
      Module(new DCArbiter(data, inputs, locking = false))
    }

    // Connect inputs to demuxes
    for (i <- 0 until inputs) {
      demuxes(i).io.sel := io.sel(i)
      demuxes(i).io.c <> io.c(i)
    }

    // Connect demux outputs to arbiter inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i).valid := demuxes(i).io.p(o).valid
        arbiters(o).io.c(i).bits := demuxes(i).io.p(o).bits
        demuxes(i).io.p(o).ready := arbiters(o).io.c(i).ready
      }
    }

    // Connect arbiters to the output
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).io.p
    }
  }
}
