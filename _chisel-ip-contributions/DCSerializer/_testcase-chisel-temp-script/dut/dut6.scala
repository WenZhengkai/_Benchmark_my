import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0.")
  require(width < data.getWidth, s"Width ($width) must be less than data.getWidth (${data.getWidth}).")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))       // Input handshaking interface
    val dataOut = Decoupled(UInt(width.W))     // Output handshaking interface
  })

  // Task 1: Calculate the number of cycles required to serialize the input data
  val cycles = (data.getWidth + width - 1) / width   // Ceiling division

  // Task 2: Implement cycle counter logic to track serialization progress
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))

  // Task 3: Split input data into fixed-width words
  // Calculate padded width
  val paddedWidth = cycles * width

  // Pad the input data to paddedWidth bits (add MSB zeros if needed)
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)

  // Split paddedData into a vector of `width`-bit chunks
  val dataChunks = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // Output serialization logic
  io.dataOut.bits := dataChunks(cycleCount)

  // Task 4: Implement handshaking logic for I/O control

  // Drive `io.dataIn.ready` signal: Module is ready for new input when all data is serialized
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Drive `io.dataOut.valid` signal
  io.dataOut.valid := io.dataIn.valid

  // Update `cycleCount` logic
  when(io.dataOut.fire) {
    // Increment cycleCount when `io.dataOut.fire` (valid & ready handshake occurs)
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }.elsewhen(io.dataIn.fire) {
    // Reset cycleCount when new data is loaded
    cycleCount := 0.U
  }
}
