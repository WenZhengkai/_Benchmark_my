import chisel3._
import chisel3.util._

// Define the DCDeserializer class
class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // Internal registers and variables
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default output signals
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataIn.ready := !dataValid

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      // Last piece of data received, set dataValid flag
      dataValid := true.B
      cycleCount := 0.U
    } .otherwise {
      // Increment cycle count
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset dataValid after transmission
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
