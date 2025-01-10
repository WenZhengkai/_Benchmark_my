
import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  require(inputs > 0, "Number of inputs must be greater than 0")
  require(outputs > 0, "Number of outputs must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // Special case: If there's only one input and one output, directly connect them
  if (inputs == 1 && outputs == 1) {
    io.p.head <> io.c.head
  } else {
    // Create a sequence of DCDemux instances, one for each input
    val demuxes = Seq.fill(inputs) {
      Module(new DCDemux(data, outputs))
    }

    // Wire up the inputs to the demuxes
    for (i <- 0 until inputs) {
      demuxes(i).io.sel := io.sel(i) // Connect selection signals
      demuxes(i).io.c <> io.c(i)     // Connect input channels
    }

    // Create a sequence of DCArbiter instances, one for each output
    val arbiters = Seq.fill(outputs) {
      Module(new DCArbiter(data, inputs, locking = false))
    }

    // Wire up the outputs from the demuxes to the input ports of the arbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)
      }
      // Connect the arbitrated output to the corresponding crossbar output
      io.p(o) <> arbiters(o).io.p
    }
  }
}
