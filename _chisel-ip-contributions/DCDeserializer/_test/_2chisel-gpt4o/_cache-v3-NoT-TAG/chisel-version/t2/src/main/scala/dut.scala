import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  // IO Definitions
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W))) // Serialized input stream
    val dataOut = Decoupled(data.cloneType)         // Deserialized parallel output
  })

  // Total bit width of the target data type
  val dataWidth = data.getWidth

  // Compute the number of cycles required for deserialization
  val cycles = (dataWidth + width - 1) / width

  // **Task 2: Register Initialization**
  // Cycle counter for deserialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))
  // Serial data segments storage
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  // Valid signal for output readiness
  val dataValid = RegInit(false.B)

  // **Task 3: Data Capture Logic**
  // Capture serial input data and update the cycle counter
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }

  // **Task 4: Deserialization Completion Logic**
  // Signal when all cycles have been captured
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B
  }

  // **Task 5: Output Acknowledgment Logic**
  // Reset valid flag when output is transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // **Task 6: Output Data Construction**
  // Combine stored serial segments into parallel output
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)

  // **Task 7: Flow Control Logic**
  // Manage valid and ready signals
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
