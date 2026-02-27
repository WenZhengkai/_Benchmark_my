import chisel3._
import chisel3.util._

class Deserializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate total data width and required cycles
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(0.U(dataWidth.W))
  val dataValid = RegInit(false.B)
  
  // Default values
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)
  
  // Deserialization process
  when(io.dataIn.fire) {
    // Store incoming data segment at the appropriate position
    val shiftAmount = cycleCount * width.U
    val mask = ((1.U << width.U) - 1.U) << shiftAmount
    val newData = io.dataIn.bits << shiftAmount
    
    dataSelect := (dataSelect & ~mask) | newData
    
    // Update cycle count
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
  
  // Reset dataValid when data is transferred out
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
