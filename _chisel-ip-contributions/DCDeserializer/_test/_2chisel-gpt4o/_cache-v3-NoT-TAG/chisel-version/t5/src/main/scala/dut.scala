import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  // Define module IO
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data
    val dataOut = Decoupled(data.cloneType)        // Output deserialized data
  })

  // Task 1: Cycle Calculation
  val dataWidth = data.getWidth                    // Total bit-width of the target data type
  val cycles = (dataWidth + width - 1) / width     // Number of cycles (rounded up)

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // Cycle counter
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))     // Holding serialized segments
  val dataValid = RegInit(false.B)                     // Flag to signal output readiness

  // Task 3: Data Capture Logic
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits          // Store serialized data segment
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Update cycleCount
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire() && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B                              // Indicate deserialization is complete
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire()) {
    dataValid := false.B                             // Clear dataValid after successful transmission
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct original parallel data

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid                      // Signal when data is ready to be output
  io.dataIn.ready := !dataValid || io.dataOut.ready  // Allow new data input if idle or after transmission
}

