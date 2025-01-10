import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W)))
    val c = Flipped(Vec(inputs, Decoupled(data.cloneType)))
    val p = Vec(outputs, Decoupled(data.cloneType))
  })

  // Optimization for single input and single output
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Create a DCDemux for each input
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data, outputs)))
    
    // Connect each input to its corresponding DCDemux
    for (i <- 0 until inputs) {
      demuxes(i).io.c <> io.c(i)
      demuxes(i).io.sel := io.sel(i)
    }
    
    // Create a DCArbiter for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect outputs of demuxes to inputs of arbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o)
      }
    }
    
    // Connect each arbiter output to corresponding output port
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).io.p
    }
  }
}
