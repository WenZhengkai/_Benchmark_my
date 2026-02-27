import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W))) // Input serialized data stream
    val dataOut = Decoupled(data.cloneType)         // Output deserialized data
  })

  // Calculate the number of cycles required for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Tracks current cycle
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Stores serialized data segments
  val dataValid  = RegInit(false.B)                 // Indicates deserialized data is ready

  // Deserialization process
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits // Store the current segment
    cycleCount := cycleCount + 1.U          // Increment cycle count

    // When the last segment is received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B  // Mark deserialized data as valid
      cycleCount := 0.U    // Reset cycle count for the next data set
    }
  }

  // Reset dataValid when the output is transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data) // Reconstruct the original data
  io.dataOut.valid := dataValid                // Signal valid deserialized data

  // Flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready for new data if output is ready or data is not valid
}

// Example usage
/*
object dut extends App {
  // Example: Deserialize a 32-bit UInt from a 8-bit serialized stream
  val dataType = UInt(32.W)
  val width = 8
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, width), args)
}
*/
