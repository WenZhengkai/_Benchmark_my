import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data stream
    val dataOut = Decoupled(data.cloneType)       // Output deserialized data
  })

  // Calculate the number of cycles required for deserialization
  val totalWidth = data.getWidth
  val cycles = (totalWidth + width - 1) / width // Ceiling division

  // Registers for internal logic
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Current cycle counter
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Vector to store serialized data segments
  val dataValid = RegInit(false.B)                  // Flag to indicate deserialized data is ready

  // Deserialization process
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits // Store the current segment
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B // Set valid flag when all segments are received
      cycleCount := 0.U   // Reset cycle counter for the next set of data
    }.otherwise {
      cycleCount := cycleCount + 1.U // Increment cycle counter
    }
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data) // Reconstruct deserialized data
  io.dataOut.valid := dataValid                // Output valid signal

  // Flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready signal for input data

  // Reset dataValid when deserialized data is transmitted
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
