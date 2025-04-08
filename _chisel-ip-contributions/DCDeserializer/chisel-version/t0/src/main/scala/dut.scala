import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serialized data input
    val dataOut = Decoupled(data.cloneType)        // Deserialized data output
  })

  // Compute total cycles required for deserialization
  val totalBits = data.getWidth                 // Total width of the data type D
  val cycles = (totalBits + width - 1) / width  // Number of cycles required, ceiling division

  // Registers to track state and intermediate data
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))  // Counter for cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))   // Vector to store segments of data
  val dataValid = RegInit(false.B)                  // Flag: Deserialized data is ready

  // Initialize output signals
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data) // Assemble output data using dataSelect

  // Handle input and deserialization logic
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready to accept new data if not processing or output is ready

  when(io.dataIn.fire) { // Input data is valid and ready
    dataSelect(cycleCount) := io.dataIn.bits  // Store incoming serialized data
    when(cycleCount === (cycles - 1).U) {    // Last cycle of deserialization
      cycleCount := 0.U                       // Reset cycle counter
      dataValid := true.B                     // Mark data as ready
    }.otherwise {
      cycleCount := cycleCount + 1.U          // Increment cycle counter
    }
  }

  // Handle output transmission
  when(io.dataOut.fire) { // Output data is being consumed
    dataValid := false.B  // Reset valid flag to indicate new deserialization can start
  }
}

// Testbench and main object can be created for simulation purposes if necessary.
