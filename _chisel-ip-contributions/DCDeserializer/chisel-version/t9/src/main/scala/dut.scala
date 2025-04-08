import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))  // Input serialized data
    val dataOut = Decoupled(data.cloneType)         // Output deserialized data
  })

  // Task 1: Cycle Calculation
  val dataWidth = data.getWidth                      // Total width of the data type
  val cycles = (dataWidth + width - 1) / width       // Number of cycles (ceiling division)

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))  // Counter to track deserialization progress
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))   // Vector to store segments of serialized data
  val dataValid = RegInit(false.B)                  // Flag to indicate output validity

  // Default assignments
  io.dataOut.bits := 0.U.asTypeOf(data)             // Initialize the default output data
  io.dataOut.valid := dataValid                     // Connect valid flag to output valid signal

  // Task 7: Flow Control Logic
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready for new input based on module state

  when(io.dataIn.fire()) {                           // Task 3: Data Input Handling
    // Store the current input segment into the appropriate register
    dataSelect(cycleCount) := io.dataIn.bits

    // Check if the current cycle is the last one
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U                             // Reset the counter for the next transaction
      dataValid := true.B                           // Mark the data as valid
    }.otherwise {
      cycleCount := cycleCount + 1.U               // Increment the counter for the next cycle
    }
  }

  // Task 5: Output Data Construction
  when(dataValid) {
    io.dataOut.bits := dataSelect.asTypeOf(data)    // Concatenate and cast segments to original data type
  }

  // Task 4: Output Transmission Handling
  when(io.dataOut.fire()) {
    dataValid := false.B                           // Reset the valid flag after sending data
  }
}
