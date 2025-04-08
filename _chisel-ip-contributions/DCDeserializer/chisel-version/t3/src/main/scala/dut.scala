

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W))) // Serialized data input
    val dataOut = Decoupled(data.cloneType)         // Deserialized data output
  })

  // --- Task 1: Cycle Calculation ---
  // Determine the number of cycles needed to deserialize `data`
  val totalBits = data.getWidth                   // Total bit width of the data
  val cycles = (totalBits + width - 1) / width    // Ceiling division

  // --- Task 2: Register Initialization ---
  // Registers to manage deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Counter to track deserialization cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Vector to store incoming segments
  val dataValid = RegInit(false.B)                  // Indicates completion of deserialization

  // --- Task 3: Data Input Handling ---
  // Handle incoming serialized data
  when(io.dataIn.fire()) {
    // Store incoming data into the vector
    dataSelect(cycleCount) := io.dataIn.bits

    // Increment cycle count or complete the process
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U  // Reset the cycle counter
      dataValid := true.B // Mark deserialization as complete
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // --- Task 4: Output Transmission Handling ---
  // Reset deserialization state after the data is sent out
  when(io.dataOut.fire()) {
    dataValid := false.B // Clear data valid flag to allow new deserialization
  }

  // --- Task 5: Output Data Construction ---
  // Concatenate data segments and cast to the original type `D`
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // --- Task 6: Output Valid Signal ---
  // Signal data validity status
  io.dataOut.valid := dataValid

  // --- Task 7: Flow Control Logic ---
  // Manage readiness of the input based on module state
  io.dataIn.ready := !dataValid || io.dataOut.ready
}

