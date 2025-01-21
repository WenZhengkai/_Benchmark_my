import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input for serialized data
    val dataOut = Decoupled(data.cloneType)         // Output for deserialized data
  })

  // Calculate the number of cycles required for complete deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // State registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default values for outputs
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Deserialization logic
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Manage ready/valid signals
  io.dataIn.ready := !dataValid // Ready for next input when current data is not valid
  when(io.dataOut.fire()) {
    dataValid := false.B         // Reset valid flag after data has been output
  }
}
