import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  // Define the input and output ports of the crossbar
  val io = IO(new Bundle {
    val sel = Vec(inputs, Input(UInt(log2Ceil(outputs).W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  // Single input/output optimization
  if (inputs == 1 && outputs == 1) {
    io.p.head <> io.c.head
  } else {
    // Create a sequence of DCDemux instances, one for each input
    val demuxes = Seq.tabulate(inputs) { i =>
      val demux = Module(new DCDemux(data, outputs))
      demux.io.sel := io.sel(i)
      demux.io.c <> io.c(i)
      demux.io
    }

    // Create a sequence of DCArbiter instances, one for each output
    val arbiters = Seq.tabulate(outputs) { o =>
      val arbiter = Module(new DCArbiter(data, inputs, locking = false))
      // Connect each demux output to the appropriate arbiter input
      for (i <- 0 until inputs) {
        arbiter.io.c(i) <> demuxes(i).p(o)
      }
      arbiter.io
    }

    // Connect the output of each arbiter to the corresponding output interface
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).p
    }
  }
}
