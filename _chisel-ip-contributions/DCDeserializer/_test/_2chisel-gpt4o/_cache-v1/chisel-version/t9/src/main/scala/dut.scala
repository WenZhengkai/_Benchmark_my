import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized data width must be greater than 0.")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W))) // Input serialized data
    val dataOut = Decoupled(data.cloneType)         // Output reconstructed parallel data
  })

  // Calculate the total number of cycles needed for deserialization
  val dataBits = data.getWidth // Total width of the data type D
  val cycles = (dataBits + width - 1) / width // Number of cycles required (ceiling division)
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Cycle counter register
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Register to hold segments of serialized data
  val dataValid = RegInit(false.B)                 // Flag to indicate deserialized data is ready

  // Input/output readiness and handshake logic
  io.dataIn.ready := !dataValid // Accept new input when output is not valid
  io.dataOut.valid := dataValid // Output valid when dataValid is true

  // Pack deserialized data into the original data type
  val reconstructedData = Wire(data.cloneType)
  reconstructedData := dataSelect.asUInt.asTypeOf(data)

  io.dataOut.bits := reconstructedData

  // Deserialization process
  when(io.dataIn.fire()) {
    // Store serialized data segment into the appropriate position
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // Check if it's the final segment
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count for the next data set
    }
  }

  // Reset dataValid flag when the output data is transmitted
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
