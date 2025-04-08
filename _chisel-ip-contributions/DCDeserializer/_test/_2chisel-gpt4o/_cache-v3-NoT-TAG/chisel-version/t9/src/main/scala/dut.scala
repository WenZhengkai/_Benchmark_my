import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serialized input stream
    val dataOut = Decoupled(data.cloneType)         // Parallel deserialized output
  })

  // Task 1: Cycle Calculation
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Calculate the number of cycles for deserialization
  
  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // Counter to track deserialization progress
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))      // Storage register for serialized segments
  val dataValid = RegInit(false.B)                      // Tracks when the result is ready for output

  // Task 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits // Save incoming serialized data in the appropriate slot
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Increment or reset counter
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B // Signal that the deserialization process is complete
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B // Reset `dataValid` after the output transaction is acknowledged
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct the parallel output data

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid // Drive `valid` signal for the output interface
  io.dataIn.ready := !dataValid || io.dataOut.ready // Allow input if not processing or output is transmitted
}
