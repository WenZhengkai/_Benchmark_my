import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required to fully deserialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Equivalent to ceil(dataWidth / width)

  // Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default assignments
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)

  when(io.dataIn.fire()) {
    // Store the incoming serialized data segment
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // Check if the last cycle of data has been received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count for the next deserialization
    }
  }

  // Reset dataValid when dataOut is successfully fired
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
