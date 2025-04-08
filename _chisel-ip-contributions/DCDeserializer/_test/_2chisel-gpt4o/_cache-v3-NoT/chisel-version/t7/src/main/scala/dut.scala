import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the data
  val cycles = (data.getWidth + width - 1) / width

  // Registers for tracking the deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization Process
  when(io.dataIn.fire()) {
    // Store the incoming serialized data
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment the cycle count
    cycleCount := cycleCount + 1.U

    // Check if this was the last cycle needed
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset for next sequence
    }
  }

  // Construct the output data from the deserialized segments
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // Flow Control
  io.dataIn.ready := !dataValid || io.dataOut.fire() // Ready for new input if not valid
  io.dataOut.valid := dataValid

  when(io.dataOut.fire()) {
    dataValid := false.B // Clear valid after successful transmission
  }
}

