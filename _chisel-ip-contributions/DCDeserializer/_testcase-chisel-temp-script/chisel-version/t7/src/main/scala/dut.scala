import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val totalWidth = data.getWidth // Total bit width of the data type `D`
  val cycles = (totalWidth + width - 1) / width // Ceiling division to calculate cycles

  // Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Counter to track deserialization progress
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // Vector register for intermediate data storage
  val dataValid = RegInit(false.B) // Signal for indicating data validity

  // Default values for output signals
  io.dataOut.valid := dataValid
  io.dataOut.bits := DontCare
  io.dataIn.ready := false.B

  // Data Input Handling
  when(io.dataIn.fire) {
    // Store incoming serialized data into dataSelect
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment cycleCount or reset and set dataValid if done
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output Data Construction
  when(dataValid) {
    // Concatenate dataSelect for deserialized data and cast to original type
    io.dataOut.bits := dataSelect.asTypeOf(data)
  }

  // Output Transmission Handling
  when(io.dataOut.fire) {
    // Clear dataValid flag after data has been transmitted
    dataValid := false.B
  }

  // Flow Control Logic
  io.dataIn.ready := !dataValid || io.dataOut.ready
}

