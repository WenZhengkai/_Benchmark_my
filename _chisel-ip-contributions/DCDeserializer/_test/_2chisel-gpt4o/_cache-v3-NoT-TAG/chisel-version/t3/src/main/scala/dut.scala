import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, val width: Int) extends Module {
  // Determine the requirement for cycles
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Rounds up for partial cycles

  // Module IO Definition
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data
    val dataOut = Decoupled(data.cloneType)        // Output deserialized data
  })

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))        // Counter for tracking cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))         // Buffer for deserialized data
  val dataValid = RegInit(false.B)                         // Output data valid signal

  // Task 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits            // Capture input data in respective cycle slot
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Increment or reset cycleCount
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B // Signal output as valid after final segment is captured
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B // Clear dataValid to indicate completion of transmission
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct full data as target type

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid                          // Drive output valid from dataValid register
  io.dataIn.ready := !dataValid || io.dataOut.ready      // Allow input if not currently valid or output ready
}

// Test the dut Implementation
