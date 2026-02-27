// package deserializer

import chisel3._
import chisel3.util._

/**
 * A module that deserializes a stream of data.
 *
 * @param data The data type to deserialize to
 * @param width The width of the input serialized data stream
 */
class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate total data width and required cycles
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(0.U(dataWidth.W))
  val dataValid = RegInit(false.B)

  // Connect output signals
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)
  io.dataOut.valid := dataValid
  
  // Control input ready signal
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Deserialization logic
  when(io.dataIn.fire) {
    // Shift in the new data bits
    val shiftAmount = cycleCount * width.U
    val mask = ((1.U << width.U) - 1.U) << shiftAmount
    val shiftedData = io.dataIn.bits << shiftAmount
    
    dataSelect := (dataSelect & ~mask) | (shiftedData & mask)
    
    when(cycleCount === (cycles - 1).U) {
      // Last cycle - data is complete
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      // Move to next cycle
      cycleCount := cycleCount + 1.U
    }
  }
  
  // Reset dataValid when output is accepted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
