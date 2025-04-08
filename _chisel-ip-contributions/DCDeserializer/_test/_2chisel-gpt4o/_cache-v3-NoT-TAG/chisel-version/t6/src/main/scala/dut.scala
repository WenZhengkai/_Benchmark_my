import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  // Input and output ports
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))    // Serialized input
    val dataOut = Decoupled(data.cloneType)           // Deserialized output
  })

  // Step 1: Calculate number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width   // Round up for partial cycles

  // Step 2: Registers for tracking state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))     // Counter for cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))      // Storage for serial segments
  val dataValid = RegInit(false.B)                      // Output valid signal

  // Step 3: Data capture logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits            // Store incoming data
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Update cycle counter
  }

  // Step 4: Deserialization completion logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B                                 // Signal output readiness
  }

  // Step 5: Output acknowledgment logic
  when(io.dataOut.fire) {
    dataValid := false.B                                // Clear output valid signal
  }

  // Step 6: Output data construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType) // Reconstruct parallel data

  // Step 7: Flow control logic
  io.dataOut.valid := dataValid                        // Drive output valid signal
  io.dataIn.ready := !dataValid || io.dataOut.ready    // Drive input ready signal
}
