import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  // Calculate the number of cycles required to deserialize the data
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling division

  // IO Ports
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Internal Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Tracks the current cycle
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Stores incoming data segments
  val dataValid  = RegInit(false.B)                 // Indicates if deserialized data is ready

  // Deserialization Logic
  when(io.dataIn.fire) {
    // Store the incoming data segment
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment the cycle counter
    cycleCount := cycleCount + 1.U
    // Check if the final segment has been received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B // Mark deserialized data as valid
      cycleCount := 0.U   // Reset cycle counter for the next set of data
    }
  }

  // Output Logic
  io.dataOut.bits := dataSelect.asTypeOf(data) // Reconstruct the deserialized data
  io.dataOut.valid := dataValid                // Signal valid output data

  // Flow Control
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready for new input if not processing or output is ready

  // Reset dataValid when the output is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}

// Example instantiation for testing
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut(UInt(32.W), 8))
}
*/
