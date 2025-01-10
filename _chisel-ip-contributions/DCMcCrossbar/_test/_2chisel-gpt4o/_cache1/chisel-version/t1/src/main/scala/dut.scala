import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(Decoupled(data.cloneType)))
    val p = Vec(outputs, Decoupled(data.cloneType))
  })

  // Single Input and Output Optimization: Direct passthrough
  if (inputs == 1 && outputs == 1) {
    io.p(0) <> io.c(0)
  } else {
    // Instantiate DCMirrors for each input
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))
    
    // Connect inputs and destination selectors to DCMirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.dst := io.sel(i)
      mirrors(i).io.c <> io.c(i)
    }
    
    // Instantiate DCArbiters for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))
    
    // Connect each arbiter's inputs to the corresponding mirrors' outputs
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
      
      // Connect arbiter outputs to the corresponding output ports
      io.p(o) <> arbiters(o).io.p
    }
  }
}
