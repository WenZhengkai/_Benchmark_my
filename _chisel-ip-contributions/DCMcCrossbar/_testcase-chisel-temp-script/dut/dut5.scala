
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
    // Simplify to direct passthrough if only one input and one output
    io.p(0) <> io.c(0)
  } else {
    // General case with multiple inputs and outputs

    // Create DCMirror instances for demultiplexing
    val demuxes = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))
    for (i <- 0 until inputs) {
      demuxes(i).io.dst := io.sel(i)
      demuxes(i).io.c <> io.c(i)
    }

    // Create DCArbiter instances for arbitration
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)
      }
      io.p(o) <> arbiters(o).io.p
    }
  }
}
