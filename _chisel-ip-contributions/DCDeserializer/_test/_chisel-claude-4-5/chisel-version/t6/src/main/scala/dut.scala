import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default ready signal
  io.dataIn.ready := !dataValid

  // Deserialization process
  when(io.dataIn.fire) {
    // Store the incoming data segment
    dataSelect(cycleCount) := io.dataIn.bits
    
    when(cycleCount === (cycles - 1).U) {
      // Last segment received
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Move to next cycle
      cycleCount := cycleCount + 1.U
    }
  }

  // Handle output acknowledgment
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asUInt.asTypeOf(data)
  io.dataOut.valid := dataValid
}
