import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required to traverse the entire data width
  val totalDataWidth = data.getWidth
  val cycles = (totalDataWidth + width - 1) / width

  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Flow control
  io.dataIn.ready := !dataValid || io.dataOut.fire
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}

// Test application of the DCDeserializer
// Simulation is required to validate this module using testbenches
