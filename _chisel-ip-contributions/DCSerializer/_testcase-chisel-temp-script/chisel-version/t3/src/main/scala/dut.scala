import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be positive")
  require(width < data.getWidth, s"Width ($width) must be less than the bit-width of the input data (${data.getWidth})")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data)) // Producer interface for input data
    val dataOut = Decoupled(UInt(width.W)) // Consumer interface for serialized output
  })

  // 1. Calculate the number of cycles required for serialization
  val cycles = (data.getWidth + width - 1) / width // Ceiling division
  val paddedWidth = cycles * width

  // 2. Pad the input data so it fits into `paddedWidth` bits
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)

  // 3. Split into chunks of `width`-bit words
  val dataSelect = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // 4. Register to track the current cycle during serialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val isLastCycle = (cycleCount === (cycles - 1).U)

  // 5. Output control logic
  io.dataOut.valid := io.dataIn.valid // Output is valid when input data is valid
  io.dataOut.bits := dataSelect(cycleCount) // Select the chunk corresponding to the current cycle
  io.dataIn.ready := isLastCycle && io.dataOut.ready // Input ready only when the last cycle completes

  // 6. Cycle count logic
  when(io.dataOut.fire()) { // Only update the cycle counter when output transaction occurs
    cycleCount := Mux(isLastCycle, 0.U, cycleCount + 1.U)
  }
}
