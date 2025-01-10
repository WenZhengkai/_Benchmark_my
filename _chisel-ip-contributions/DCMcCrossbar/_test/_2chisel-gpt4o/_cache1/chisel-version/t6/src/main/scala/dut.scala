import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(Decoupled(data.cloneType)))
    val p = Vec(outputs, Decoupled(data.cloneType))
  })

  if (inputs == 1 && outputs == 1) {
    // Single input and output optimization
    io.p(0) <> io.c(0)
  } else {
    // General case with more than one input or output
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connecting inputs to DCMirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.c <> io.c(i)
      mirrors(i).io.dst := io.sel(i)
    }

    // Connecting DCMirrors outputs to DCArbiters inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connecting DCArbiters outputs to module outputs
      io.p(o) <> arbiters(o).io.p
    }
  }
}
