import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input serialized data stream
    val dataOut = Decoupled(data.cloneType)        // Output deserialized data
  })

  // Calculate the number of cycles required to reconstruct the data
  val dataBits = data.getWidth
  val cycles = (dataBits + width - 1) / width // Equivalent to ceil(dataBits / width)

  // Registers and initializations
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W))) // Stores segments of incoming data
  val dataValid = RegInit(false.B) // Indicates if the deserialized data is ready

  // Deserialization process
  when(io.dataIn.fire) {
    // Store the incoming data in the appropriate position
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // Check if final segment has been received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Manage handshake signals
  io.dataIn.ready := !dataValid || io.dataOut.ready
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
