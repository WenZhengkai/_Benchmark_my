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
    // Single Input and Output Optimization
    io.p(0) <> io.c(0)
  } else {
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect inputs to mirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.dst := io.sel(i)
      mirrors(i).io.c <> io.c(i)
    }

    // Connect mirrors to arbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      // Connect arbiters to outputs
      io.p(o) <> arbiters(o).io.p
    }
  }
}

