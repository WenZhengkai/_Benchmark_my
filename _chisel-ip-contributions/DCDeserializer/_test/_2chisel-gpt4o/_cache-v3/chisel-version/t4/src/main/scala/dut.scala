import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  // Calculate the number of cycles needed to deserialize the incoming data
  private val cycles = (data.getWidth + width - 1) / width

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data
    val dataOut = Decoupled(data.cloneType) // Output deserialized data
  })

  // Registers and state
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // If we have received all cycles for the current data, prepare for output
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output construction from deserialized segments
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Manage flow control
  io.dataIn.ready := !dataValid || io.dataOut.fire()

  // Reset the validity flag when data is successfully transmitted
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}

// Don't forget to import this code into a Chisel test environment or invoke it within a top-level module for practical use.
