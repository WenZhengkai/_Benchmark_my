import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))     // Input serialized data stream
    val dataOut = Decoupled(data.cloneType)            // Output reconstructed parallel data
  })

  // Calculate the number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // Registers for tracking deserialization state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))     // Temporary storage for incoming data
  val dataValid = RegInit(false.B)                    // Indicates when deserialization is complete

  // Default I/O behavior
  io.dataIn.ready := !dataValid || io.dataOut.ready   // Ready when idle or output ready
  io.dataOut.valid := dataValid                      // Output valid when data is complete
  io.dataOut.bits := dataSelect.asTypeOf(data)       // Construct output data from the vector

  // Input handling logic
  when(io.dataIn.fire()) {
    // Store the incoming segment in the appropriate position
    dataSelect(cycleCount) := io.dataIn.bits
    // Update the cycle counter
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B                           // Mark data as valid when complete
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output handling logic
  when(io.dataOut.fire()) {
    dataValid := false.B                            // Reset valid flag after data is consumed
  }
}
