

import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // If there is only one input and one output, use direct passthrough
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Create vector of DCMirror modules for each input
    val mirrors = Seq.fill(inputs) {
      Module(new DCMirror(data, outputs))
    }

    // Connect inputs to DCMirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.c <> io.c(i)
      mirrors(i).io.dst := io.sel(i)
    }

    // Create vector of DCArbiter modules for each output
    val arbiters = Seq.fill(outputs) {
      Module(new DCArbiter(data, inputs, locking = false))
    }

    // Connect DCMirror outputs to appropriate DCArbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connect the output of each arbiter to the corresponding output port
      io.p(o) <> arbiters(o).io.p
    }
  }
}
