import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
  * A multi-destination crossbar module that provides communication between multiple 
  * sources and multiple destinations using selection signals.
  *
  * @param data The data type of the input/output interface.
  * @param inputs The number of input ports in the crossbar.
  * @param outputs The number of output ports in the crossbar.
  */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(DecoupledIO(data.cloneType)))
    val p = Vec(outputs, DecoupledIO(data.cloneType))
  })

  if (inputs == 1 && outputs == 1) {
    // Single Input and Output Optimization
    io.p(0) <> io.c(0)
  } else {
    // General Case
    // Create a mirror for each input
    val mirrors = Seq.fill(inputs)(Module(new DCMirror(data, outputs)))

    // Connect input and selection signals to mirrors
    for (i <- 0 until inputs) {
      mirrors(i).io.c <> io.c(i)
      mirrors(i).io.dst := io.sel(i)
    }

    // Create an arbiter for each output
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data, inputs, locking = false)))

    // Connect mirrors to inputs of appropriate arbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> mirrors(i).io.p(o)
      }
    }

    // Connect arbiters to output ports
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).io.p
    }
  }
}

// Example usage:
// class ExampleTopLevel extends Module {
//   val dataWidth = 32
//   val crossbar = Module(new DcMcCrossbar(UInt(dataWidth.W), inputs = 4, outputs = 4))
//   // Connect the crossbar to other parts of your design...
// }
