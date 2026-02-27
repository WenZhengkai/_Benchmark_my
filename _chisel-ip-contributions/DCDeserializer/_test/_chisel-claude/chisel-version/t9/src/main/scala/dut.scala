import chisel3._
import chisel3.util._

class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate total number of cycles needed for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division

  // Registers for tracking state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(0.U(dataWidth.W))
  val dataValid = RegInit(false.B)

  // Default values
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)

  // Process incoming data when valid and ready
  when(io.dataIn.fire) {
    // Store the current segment in the appropriate position
    val shiftAmount = cycleCount * width.U
    val mask = ((1.U << width.U) - 1.U) << shiftAmount
    val shiftedData = io.dataIn.bits << shiftAmount
    
    dataSelect := (dataSelect & ~mask) | (shiftedData & mask)
    
    // Check if this is the last cycle
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset dataValid when output is consumed
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
