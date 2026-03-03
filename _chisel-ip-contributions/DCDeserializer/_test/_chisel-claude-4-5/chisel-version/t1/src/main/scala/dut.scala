import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire) {
    // Store the incoming data segment at the current cycle position
    dataSelect(cycleCount) := io.dataIn.bits
    
    when(cycleCount === (cycles - 1).U) {
      // Last segment received, set dataValid and reset cycleCount
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Increment cycle count for next segment
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset dataValid when output is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Input ready signal: ready to accept new data when not valid or when output is being consumed
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
