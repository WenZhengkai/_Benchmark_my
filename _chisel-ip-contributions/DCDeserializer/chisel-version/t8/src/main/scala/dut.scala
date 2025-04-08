import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data channel
    val dataOut = Decoupled(data.cloneType)        // Output deserialized data channel
  })

  // Step 1: Calculate the number of cycles required for deserialization
  val totalDataWidth = data.getWidth              // Total width of the parallel data
  val cycles = (totalDataWidth + width - 1) / width // Ceiling division to compute cycles

  // Step 2: Register initialization to track deserialization state and data
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Counter for tracking cycles
  val dataValid = RegInit(false.B)                  // Flag to indicate deserialization completion
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Vector register to store intermediate data segments

  // Step 3: Data input handling
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready signal logic for `dataIn`

  when(io.dataIn.fire) { // When dataIn is valid and ready
    dataSelect(cycleCount) := io.dataIn.bits       // Store current data segment
    when(cycleCount === (cycles - 1).U) {         // If it's the last cycle
      cycleCount := 0.U                           // Reset the cycle counter
      dataValid := true.B                         // Set valid flag to true
    }.otherwise {
      cycleCount := cycleCount + 1.U              // Increment the cycle counter
    }
  }

  // Step 4: Output data construction
  io.dataOut.bits := dataSelect.asTypeOf(data)    // Concatenate and cast intermediate data to original type
  io.dataOut.valid := dataValid                   // Set valid signal for `dataOut`

  // Step 5: Output transmission handling
  when(io.dataOut.fire) { // When dataOut is valid and ready
    dataValid := false.B                          // Reset valid flag for new deserialization cycle
  }
}

// Example usage:
// val deserializer = Module(new dut(UInt(64.W), 8))
// This creates a deserializer that reconstructs a 64-bit word using an 8-bit serialized stream.
