import chisel3._
import chisel3.util._

class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the total width of the data type
  val dataWidth = data.getWidth
  
  // Calculate the number of cycles needed to receive the complete data
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Create a register to track the current cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Register to accumulate the incoming data
  val dataSelect = RegInit(0.U(dataWidth.W))
  
  // Register to indicate when data is valid
  val dataValid = RegInit(false.B)
  
  // Default state for input/output interfaces
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)
  
  // Processing logic for incoming data
  when(io.dataIn.fire) {
    // Store the incoming data segment at the appropriate position in dataSelect
    val shiftAmount = cycleCount * width.U
    val mask = ((1.U << width.U) - 1.U) << shiftAmount
    val shiftedData = io.dataIn.bits << shiftAmount
    
    dataSelect := (dataSelect & ~mask) | (shiftedData & mask)
    
    // Update cycle count and set valid flag when all segments are received
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
  
  // Reset dataValid when the output is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
