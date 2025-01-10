import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  if (inputs == 1 && outputs == 1) {
    // Single input and output optimization: direct passthrough
    io.p(0) <> io.c(0)
  } else {
    // General case
    // Create DCMirror instances for each input
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))

    // Connect inputs to their respective mirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.c <> io.c(i)
      mirrors(i).io.dst := io.sel(i)
    }

    // Create DCArbiter instances for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect DCMirror outputs to DCArbiter inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connect arbiter outputs to the crossbar's outputs
      io.p(o) <> arbiters(o).io.p
    }
  }
}
