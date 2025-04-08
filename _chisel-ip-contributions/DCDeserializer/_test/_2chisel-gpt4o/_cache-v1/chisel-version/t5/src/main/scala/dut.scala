

import chisel3._
import chisel3.util._

/**
 * DCDeserializer module: Converts serialized data stream into a parallel multi-bit word.
 *
 * @param data The Chisel Data type of the output data after deserialization.
 * @param width The width (in bits) of the serialized data channel.
 * @tparam D Subtype of Data for specifying the output deserialized data type.
 */
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized data width must be greater than 0.")

  val io = IO(new Bundle {
    // Input serialized data stream
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    // Output deserialized data
    val dataOut = Decoupled(data.cloneType)
  })

  // Total number of bits in the output data type
  val totalBits: Int = data.getWidth
  require(totalBits > 0, "Output data type must have a width greater than 0.")

  // Calculate the number of cycles required for deserialization
  val cycles: Int = (totalBits + width - 1) / width // Ceiling division
  val cycleCountWidth: Int = log2Ceil(cycles)

  // Registers and internal states
  val cycleCount = RegInit(0.U(cycleCountWidth.W)) // Keep track of current cycle
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // Vector to collect serialized segments
  val dataValid = RegInit(false.B)                 // Indicates if deserialized data is ready

  // Default values for IO signals
  io.dataIn.ready := !dataValid // Ready to accept data if no deserialized data is currently valid
  io.dataOut.valid := dataValid
  io.dataOut.bits := data // Default output, to be reassigned below

  // Logic for accumulating serialized data
  when(io.dataIn.fire()) { // Triggered when dataIn.valid && dataIn.ready
    // Store incoming serialized data in the corresponding cycle
    dataSelect(cycleCount) := io.dataIn.bits

    // Increment cycleCount or reset when we reach the last cycle
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B // Mark data as ready after full deserialization
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output logic: Assemble full data from collected segments
  io.dataOut.bits := Cat(dataSelect.reverse) // Concatenate segments, MSB first

  // Handshake with dataOut: Consume valid deserialized data when dataOut fires
  when(io.dataOut.fire()) {
    dataValid := false.B // Reset valid flag to start accepting new serialized data
  }
}

