import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, val width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))  // Serialized input data
    val dataOut = Decoupled(data.cloneType)          // Deserialized output data
  })

  // Step 1: Number of cycles calculation
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // Step 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Counter for tracking the current cycle
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Register to store segment data
  val dataValid = RegInit(false.B)                  // Readiness register for output data

  // Step 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits                  // Store incoming data at current cycle index
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Increment or reset the cycle counter
  }

  // Step 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B                                       // Signal completion of deserialization
  }

  // Step 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B                                      // Reset valid signal after data is transmitted
  }

  // Step 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)      // Reconstruct parallel data

  // Step 7: Flow Control Logic
  io.dataOut.valid := dataValid                               // Output valid flag
  io.dataIn.ready := !dataValid || io.dataOut.ready           // Input ready condition

  // Optional: Debugging/Assertions (for testing purposes)
  assert(width > 0, "Width must be greater than 0.")
  assert(dataWidth > 0, "Data width must be greater than 0.")
}
