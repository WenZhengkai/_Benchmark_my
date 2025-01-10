
import chisel3._
import chisel3.util._
import chisel.lib.dclib._

/**
  * DCCrossbar: A parameterized crossbar module allowing M input ports to connect to N output ports.
  * It ensures non-blocking communication if no two inputs request the same output.
  *
  * @param data    Generic data type for the module's input/output data interfaces.
  * @param inputs  Number of input ports in the crossbar.
  * @param outputs Number of output ports in the crossbar.
  */
class dut[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  require(inputs > 0 && outputs > 0, "Number of inputs and outputs must be greater than 0.")
  
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(log2Ceil(outputs).W))) // Selection signals for inputs
    val c   = Vec(inputs, Flipped(DecoupledIO(data.cloneType))) // Input ports
    val p   = Vec(outputs, DecoupledIO(data.cloneType))          // Output ports
  })
  
  // Single Input/Output Optimization:
  if (inputs == 1 && outputs == 1) {
    io.p.head <> io.c.head // Directly connect input and output
  } else {
    // Create a sequence of DCDemux instances for all input channels
    val demuxes = Seq.fill(inputs)(Module(new DCDemux(data.cloneType, outputs)))
    
    // Create a sequence of DCArbiter instances for all output channels
    val arbiters = Seq.fill(outputs)(Module(new DCArbiter(data.cloneType, inputs, locking = false)))
    
    // Connect input interfaces to the DCDemux instances
    for (i <- 0 until inputs) {
      demuxes(i).io.c <> io.c(i)               // Connect input data to the demux
      demuxes(i).io.sel := io.sel(i)           // Assign selection signal for each demux
    }
    
    // Connect outputs of the DCDemuxes to the inputs of the DCArbiters
    for (o <- 0 until outputs) {
      for (i <- 0 until inputs) {
        arbiters(o).io.c(i) <> demuxes(i).io.p(o) // Connect each demux output to its corresponding arbiter input
      }
    }
    
    // Connect arbiter outputs to the crossbar's outputs
    for (o <- 0 until outputs) {
      io.p(o) <> arbiters(o).io.p // Assign each output port to the arbiter's output
    }
  }
}

// Example Testbench (Optional):
// Uncomment to test the DCCrossbar module
// object DCCrossbarMain extends App {
//   println(getVerilog(new DCCrossbar(UInt(8.W), 4, 4))) // 4x4 crossbar with 8-bit data
// }
