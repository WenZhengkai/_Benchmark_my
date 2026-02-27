// package serialization

import chisel3._
import chisel3.util._

/** Deserializer module to convert serial data back to multi-bit parallel form
  *
  * @param data Chisel data type to be reconstructed from serialization
  * @param width Width of the serialized data channel in bits
  * @tparam D The type of the data being deserialized
  */
class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    // Input serialized data stream
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    // Output deserialized data
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the total width of the data type
  val dataWidth = data.getWidth
  
  // Calculate number of cycles needed to receive the complete data
  val cycles = (dataWidth + width - 1) / width
  
  // Register to track the current deserialization cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Register to store data segments as they arrive
  val dataSelect = RegInit(0.U(dataWidth.W))
  
  // Flag to indicate when deserialized data is valid
  val dataValid = RegInit(false.B)
  
  // Default signal values
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)
  
  // Default ready signal - only ready for more input when not holding valid output data
  // or when the output is ready to accept the current data
  io.dataIn.ready := !dataValid || io.dataOut.ready
  
  // Process incoming data when valid and ready
  when(io.dataIn.fire) {
    // Store the current segment at the appropriate position in the data register
    dataSelect := Cat(
      dataSelect(dataWidth - 1, (cycleCount + 1.U) * width.U),
      io.dataIn.bits,
      dataSelect(((cycleCount * width.U) - 1.U), 0.U)
    )
    
    // Check if this is the last segment
    when(cycleCount === (cycles - 1).U) {
      // Reset cycle counter and mark data as valid
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      // Increment cycle counter
      cycleCount := cycleCount + 1.U
    }
  }
  
  // When output data is accepted, clear valid flag
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
