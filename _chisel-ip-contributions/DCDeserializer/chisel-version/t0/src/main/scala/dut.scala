import chisel3._
import chisel3.util._

/** Serial to Parallel converter that reconstructs serialized data
  * 
  * @param data The Chisel data type to be reconstructed
  * @param width The width of the serialized data channel in bits
  */
class SerialToParallel[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    // Input serialized data stream
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    // Output deserialized data
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the total number of bits in the data type
  val dataWidth = data.getWidth
  
  // Calculate the number of cycles needed to deserialize the data
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Register to track the current cycle in the deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Register to store the accumulated serialized data segments
  val dataSelect = RegInit(0.U(dataWidth.W))
  
  // Register to track if deserialized data is valid and ready to be output
  val dataValid = RegInit(false.B)

  // Default values
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Process incoming serialized data
  when(io.dataIn.fire) {
    // Store incoming data segment at the appropriate position based on current cycle
    dataSelect := Cat(
      dataSelect(dataWidth - 1, (cycleCount + 1.U) * width.U),
      io.dataIn.bits,
      dataSelect((cycleCount * width.U) - 1.U, 0.U)
    )

    // Increment cycle count or reset if this is the last cycle
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset data valid flag when output is consumed
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
