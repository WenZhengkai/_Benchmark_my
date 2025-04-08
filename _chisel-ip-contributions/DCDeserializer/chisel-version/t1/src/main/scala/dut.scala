

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(data.getWidth > 0, "Data width must be greater than 0")
  
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serialized input stream
    val dataOut = Decoupled(data.cloneType)        // Deserialized output word
  })

  // Compute the number of cycles required for deserialization
  val cycles = (data.getWidth + width - 1) / width

  // Registers and state storage
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))             // Counter to track cycles
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))              // Buffer to store serialized slices
  val dataValid = RegInit(false.B)                              // Valid flag for output

  // Input ready condition
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Data input handling
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits                    // Store inbound serialized data
    when(cycleCount === (cycles - 1).U) {                       // Last cycle reached
      dataValid := true.B                                       // Mark data as valid
      cycleCount := 0.U                                         // Reset cycle count
    }.otherwise {
      cycleCount := cycleCount + 1.U                            // Increment cycle count
    }
  }

  // Output transmission logic
  when(io.dataOut.fire()) {
    dataValid := false.B                                        // Reset valid flag once data is sent
  }

  // Output data construction
  io.dataOut.bits := dataSelect.asTypeOf(data)                  // Reconstruct full data from segments

  // Output valid signal
  io.dataOut.valid := dataValid
}

