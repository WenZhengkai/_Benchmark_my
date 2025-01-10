import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
  * Parameterizable Crossbar module using DCDemux and DCArbiter
  *
  * @param data    Data type for input/output data interfaces
  * @param inputs  Number of input ports
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

  // Handle single input and single output case directly
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Instantiate the demultiplexers for each input
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data.cloneType, outputs)))
    for (i <- 0 until inputs) {
      demuxes(i).io.sel := io.sel(i) // Connect the selection signal
      demuxes(i).io.c <> io.c(i)    // Connect the input interface
    }

    // Instantiate the arbiters for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data.cloneType, inputs, locking = false)))
    for (j <- 0 until outputs) {
      // Connect each demux output to the corresponding arbiter input
      for (i <- 0 until inputs) {
        arbiters(j).io.c(i) <> demuxes(i).io.p(j)
      }
      io.p(j) <> arbiters(j).io.p // Connect arbiter output to the crossbar's output interface
    }
  }
}


