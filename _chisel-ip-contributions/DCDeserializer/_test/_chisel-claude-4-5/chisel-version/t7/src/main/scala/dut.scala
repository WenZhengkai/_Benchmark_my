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

  // Reset dataValid when output fires
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asUInt.asTypeOf(data)
  io.dataOut.valid := dataValid
  
  // Input ready control
  // Accept new data when not valid or when output is being consumed
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Alternative ready logic based on specification:
  // Only ready when we're not holding valid data
  // Uncomment the line below if you want stricter flow control
  // io.dataIn.ready := !dataValid
}
