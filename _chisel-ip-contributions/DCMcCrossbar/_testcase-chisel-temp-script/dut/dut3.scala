

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
    // Optimization for single input and output: direct passthrough
    io.p.head <> io.c.head
  } else {
    // Full crossbar logic for multiple inputs/outputs
    // Create DCMirror instances for each input
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))

    // Connect each input to the corresponding DCMirror
    for (i <- 0 until inputs) {
      mirrors(i).io.dst := io.sel(i)
      mirrors(i).io.c <> io.c(i)
    }

    // Create DCArbiter instances for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect the DCMirror outputs to the DCArbiter inputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connect DCArbiter output to module output
      io.p(o) <> arbiters(o).io.p
    }
  }
}
