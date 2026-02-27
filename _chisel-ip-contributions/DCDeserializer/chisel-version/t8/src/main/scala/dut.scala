import chisel3._
import chisel3.util._

class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the total number of bits in the data type
  val totalBits = data.getWidth

  // Calculate the number of cycles needed to deserialize the data
  val cycles = (totalBits + width - 1) / width  // Ceiling division

  // Cycle counter
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Data collection register
  val dataSelect = RegInit(0.U(totalBits.W))
  
  // Valid flag for output data
  val dataValid = RegInit(false.B)

  // Default values
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)

  // Deserialization process
  when(io.dataIn.fire) {
    // Shift in the incoming data at the appropriate position
    dataSelect := dataSelect | (io.dataIn.bits << (cycleCount * width.U)).asUInt
    
    when(cycleCount === (cycles - 1).U) {
      // When we've received the last segment
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      // Move to the next cycle
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset the data valid flag when data is accepted
  when(io.dataOut.fire) {
    dataValid := false.B
    dataSelect := 0.U  // Clear the data for the next transaction
  }
}
