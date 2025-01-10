import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(dataType.cloneType)
  })

  // Calculate the number of cycles needed to receive the full data
  val totalWidth = dataType.getWidth
  val cycles = (totalWidth + width - 1) / width // Calculate required cycles, round up
  
  // Registers to keep track of the deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default Values
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataType

  when(io.dataIn.fire()) {
    // Store the received segment
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      // Indicating data is valid when all cycles are received
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count for the next transaction
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire()) {
    dataValid := false.B // Reset data validity after output is consumed
  }

  // Reconstruct the full data from segments
  io.dataOut.bits := Cat(dataSelect.reverse) // Join the segments back to the original data width
}


