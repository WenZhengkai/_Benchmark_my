import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serialized input data
    val dataOut = Decoupled(data.cloneType)        // Deserialized output data
  })

  // Task 1: Cycle Calculation
  val dataWidth = data.getWidth                  // Total bit-width of the data type `D`
  val cycles = (dataWidth + width - 1) / width   // Number of cycles to process input data

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // Cycle counter
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))     // Stores incoming serial segments
  val dataValid = RegInit(false.B)                     // Flag for output readiness

  // Task 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits          // Store input segment into register
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Cycle counter update
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B                              // Signal that deserialization is complete
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B                             // Reset `dataValid` when output is transmitted
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct parallel data from stored segments

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid                    // Output is valid when deserialization is complete
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready to accept new data if not busy
}

// Testbench class would go here (if needed) to verify the dut module functionality.
