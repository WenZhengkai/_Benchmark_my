import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than zero")
  require(data.getWidth > 0, "Data width must be greater than zero")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))  // Input serialized data, Decoupled
    val dataOut = Decoupled(data.cloneType)         // Output deserialized data, Decoupled
  })

  // Task 1: Cycle Calculation
  val dataWidth = data.getWidth                   // Total bits in the target data type
  val cycles = (dataWidth + width - 1) / width    // Number of clock cycles for complete deserialization
  val cycleCountBits = log2Ceil(cycles + 1)       // Number of bits to represent cycleCount

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(cycleCountBits.W)) // Counter to track the deserialization progress
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // Registers to store serialized data segments
  val dataValid = RegInit(false.B)                // Validity flag for `dataOut`

  // Task 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits      // Store incoming serialized data
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Wrap or increment counter
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B                          // Mark the deserialization completion
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B                         // Reset validity after data is transmitted
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct parallel data from stored segments

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid                  // Output valid signal driven by `dataValid`
  io.dataIn.ready := !dataValid || io.dataOut.ready // Input ready signal based on `dataValid` and `dataOut.ready`
}
