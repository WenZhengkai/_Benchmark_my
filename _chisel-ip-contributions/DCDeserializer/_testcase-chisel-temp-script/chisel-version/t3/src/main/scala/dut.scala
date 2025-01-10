import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate number of cycles required to deserialize a single parallel word
  val totalWidth = data.getWidth
  val cycles = (totalWidth + width - 1) / width // Ceiling division of totalWidth by width

  // Internal registers for cycle count, data selection, and data valid state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default outputs
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid || io.dataOut.fire

  // Deserialization process
  when(io.dataIn.fire) {
    // Store incoming serialized data into the correct segment
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment the cycle count or reset it if final segment is reached
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
    // Set dataValid if final segment is reached
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
    }
  }

  // Construct the output data from accumulated segments in dataSelect
  io.dataOut.bits := data.fromBits(dataSelect.asUInt())

  // Reset dataValid flag once the data has been successfully sent out
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}


