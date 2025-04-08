import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  // Width of the input channel and total output data
  require(width > 0, "Width of serialized channel must be greater than zero")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized stream
    val dataOut = Decoupled(data.cloneType)        // Output deserialized data
  })

  // Calculate the number of cycles required to fully deserialize the input stream
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceil(totalBits / width)
  val cycleCountBits = log2Ceil(cycles)

  // Internal Registers
  val cycleCount = RegInit(0.U(cycleCountBits.W)) // Track the number of cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // Store chunks of serialized data
  val dataValid = RegInit(false.B)                // Flag to mark deserialized data readiness

  // Default values for IO
  io.dataIn.ready := !dataValid // Ready to accept new serialized data unless dataValid is high
  io.dataOut.valid := dataValid // `dataOut.valid` reflects whether deserialization is complete
  io.dataOut.bits := data.cloneType.fromBits(
    dataSelect.asUInt()(totalBits - 1, 0) // Reconstruct the data from collected segments
  )

  // Deserialization process
  when(io.dataIn.fire()) {
    // Store incoming serialized data into the correct position in dataSelect
    dataSelect(cycleCount) := io.dataIn.bits
    // Advance the cycle counter
    cycleCount := cycleCount + 1.U

    // If this is the last cycle, mark data as valid and reset the cycle count
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // When deserialized data is successfully transmitted, clear the valid flag
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
