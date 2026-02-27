// package deserializer

import chisel3._
import chisel3.util._

class SerialToParallelConverter[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate total number of cycles needed for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width  // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(0.U(totalBits.W))
  val dataValid = RegInit(false.B)

  // Default values
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)

  // Process incoming data
  when(io.dataIn.fire) {
    // Store the incoming data segment at the appropriate position in dataSelect
    val shiftAmount = cycleCount * width.U
    dataSelect := dataSelect | (io.dataIn.bits << shiftAmount)
    
    when(cycleCount === (cycles - 1).U) {
      // Last segment received, mark as valid and reset cycle counter
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Increment cycle counter for next segment
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset data valid when output is consumed
  when(io.dataOut.fire) {
    dataValid := false.B
    dataSelect := 0.U  // Clear data register for next transaction
  }
}

// Optional companion object for easier instantiation
object SerialToParallelConverter {
  def apply[D <: Data](data: D, width: Int): SerialToParallelConverter[D] = 
    new SerialToParallelConverter(data, width)
}
