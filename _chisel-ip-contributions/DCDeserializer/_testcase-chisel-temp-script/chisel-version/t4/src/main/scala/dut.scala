import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // --- Task 1: Compute the number of cycles required ---
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling division

  // --- Task 2: Register Initialization ---
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Counter to track cycle
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // To store intermediate data
  val dataValid = RegInit(false.B) // Flag for completion of deserialization

  // --- Default signal assignments ---
  io.dataIn.ready := false.B
  io.dataOut.valid := dataValid
  io.dataOut.bits := 0.U.asTypeOf(data)

  // --- Task 3: Data Input Handling ---
  when(io.dataIn.fire()) {
    // Store incoming data in dataSelect
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment cycleCount unless it's the last cycle
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // --- Task 5: Output Data Construction ---
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // --- Task 4: Output Transmission Handling ---
  when(io.dataOut.fire()) {
    dataValid := false.B // Reset dataValid flag after transmission
  }

  // --- Task 6: Output Valid Signal ---
  io.dataOut.valid := dataValid

  // --- Task 7: Flow Control Logic ---
  // Set input ready signal
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
