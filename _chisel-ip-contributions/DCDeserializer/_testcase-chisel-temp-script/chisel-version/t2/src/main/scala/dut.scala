import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Input handshaking
  io.dataIn.ready := !dataValid || io.dataOut.fire()

  when(io.dataIn.fire()) {
    // Store incoming data segment
    dataSelect(cycleCount) := io.dataIn.bits

    // Update cycle counter
    cycleCount := cycleCount + 1.U

    // Check if deserialization is complete
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset cycle counter
    }
  }

  // Construct the output data from collected segments
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Output handshake
  when(io.dataOut.fire()) {
    dataValid := false.B // Reset dataValid when outputting data
  }
}


