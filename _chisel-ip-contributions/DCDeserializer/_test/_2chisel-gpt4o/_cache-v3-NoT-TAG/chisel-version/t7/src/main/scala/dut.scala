import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))  // Input serialized data
    val dataOut = Decoupled(data.cloneType)          // Output deserialized data
  })

  // Total bit-width of the target data type
  val dataWidth = data.getWidth

  // Calculate the number of cycles required to deserialize
  val cycles = (dataWidth + width - 1) / width

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // Cycle counter register
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))      // Data storage for serial segments
  val dataValid  = RegInit(false.B)                    // Valid signal for output
  
  // Task 3: Data Capture Logic
  when(io.dataIn.fire) { 
    dataSelect(cycleCount) := io.dataIn.bits          // Capture incoming segment
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Increment cycle count
  }
  
  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B  // Set valid signal when last segment is received
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B  // Clear valid signal after data is transmitted
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Convert stored segments to data type
  
  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid                        // Output valid driven by dataValid
  io.dataIn.ready := !dataValid || io.dataOut.ready    // Allow input when idle or output is ready
}
