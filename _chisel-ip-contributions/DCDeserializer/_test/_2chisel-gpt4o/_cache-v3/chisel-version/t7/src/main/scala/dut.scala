import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the full word
  val dataTotalWidth = data.cloneType.getWidth
  val cycles = (dataTotalWidth + width - 1) / width  // Ceiling division

  // Create registers for deserialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default assignment for flow control
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits  // Store current segment
    cycleCount := cycleCount + 1.U

    // Check if the final segment is received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U  // Reset cycle count for the next operation
    }
  }

  // Check if the deserialized data is successfully transmitted
  when(io.dataOut.fire()) {
    dataValid := false.B  // Ready for the next data deserialization
  }

  // Assemble the output data from collected segments
  io.dataOut.bits := dataSelect.asTypeOf(data)
}

