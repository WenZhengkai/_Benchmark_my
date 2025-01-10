import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(new DecoupledIO(data.cloneType)))
    val p = Vec(outputs, new DecoupledIO(data.cloneType))
  })

  // Single input/output optimization: Directly connect input to output
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Create a vector of DCMirrors for demultiplexing the input data
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))

    // Connect each input to its respective DCMirror module
    for (i <- 0 until inputs) {
      mirrors(i).io.c <> io.c(i)
      mirrors(i).io.dst := io.sel(i)  // Use the selection mask for routing
    }

    // Create a vector of DCArbiters for arbitrating outputs
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect the outputs of each DCMirror to the inputs of each DCArbiter
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connect the arbitrated output to the output vector
      io.p(o) <> arbiters(o).io.p
    }
  }
}
