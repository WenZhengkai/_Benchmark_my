import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Width must be less than the bit-width of the input data.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Calculate the number of cycles required to serialize the input data
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width  // Ceiling division

  // Task 2: Implement cycle counter logic
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // To address all cycles + 1 for reset condition

  when(io.dataIn.fire) {
    cycleCount := 0.U // Reset cycle count when new transaction starts
  }.elsewhen(io.dataOut.fire) {
    cycleCount := cycleCount + 1.U // Increment for each serialized word
  }

  // Task 3: Split input data into fixed-width words (with padding if needed)
  // Calculate padded width in case input data is not divisible by width
  val paddedWidth = cycles * width
  val paddedData = Cat(0.U((paddedWidth - totalBits).W), io.dataIn.bits.asUInt) // Pad with leading zeros
  val dataChunks = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // Task 4: Implement handshaking logic
  // Drive `io.dataOut.bits` with the correct data chunk
  io.dataOut.bits := dataChunks(cycleCount)

  // Drive `io.dataIn.ready`
  // Accept new data only when all cycles are complete and ready to transmit more
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Drive `io.dataOut.valid`
  // Valid output whenever the input is valid and we are not waiting for a new transaction
  io.dataOut.valid := io.dataIn.valid
}
