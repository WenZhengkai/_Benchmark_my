import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized data channel width must be greater than 0")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data
    val dataOut = Decoupled(data.cloneType)        // Output parallel deserialized data
  })

  // Calculate the total number of cycles required to deserialize the data
  val totalBits = data.getWidth
  require(totalBits > 0, "Data width must be greater than 0")

  val cycles = (totalBits + width - 1) / width // Equivalent to ceil(totalBits / width)

  // Internal state registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))               // Keeps track of the deserialization progress
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))                // Buffer for storing serialized pieces
  val dataValid = RegInit(false.B)                                // Indicates whether deserialized data is ready

  val fullDataWire = VecInit(dataSelect).asUInt // Concatenate all segments into a wide wire

  // Default outputs
  io.dataIn.ready := !dataValid // Accept new data only if the output is not valid
  io.dataOut.valid := dataValid // Output is valid if deserialization is complete
  io.dataOut.bits := data.cloneType.fromBits(fullDataWire) // Convert concatenated wire back to target type

  when(io.dataIn.fire()) { // When input is valid and ready
    // Store the incoming serialized data into the appropriate segment
    dataSelect(cycleCount) := io.dataIn.bits

    // Check if this is the final piece of data
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B       // Mark deserialization as complete
      cycleCount := 0.U         // Reset cycle counter for next operation
    }.otherwise {
      cycleCount := cycleCount + 1.U // Increment cycle counter
    }
  }

  when(io.dataOut.fire()) { // When deserialized data is successfully output
    dataValid := false.B // Clear the valid flag to allow next deserialization
  }
}
