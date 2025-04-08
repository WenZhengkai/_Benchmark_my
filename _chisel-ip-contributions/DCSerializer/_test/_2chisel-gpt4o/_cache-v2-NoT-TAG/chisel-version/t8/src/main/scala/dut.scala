import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "The input data width must be greater than the serialized output word width.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))        // Input for the data structure to serialize
    val dataOut = Decoupled(UInt(width.W))      // Output for serialized data words
  })

  // Task 1: Calculate the number of cycles required for serialization
  val cycles = (data.getWidth + width - 1) / width

  // Task 2: Track serialization progress with a register for the cycle counter
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))

  when(io.dataOut.fire) {
    cycleCount := cycleCount + 1.U
  }.elsewhen(io.dataIn.fire) { // Reset when a new transaction starts
    cycleCount := 0.U
  }

  // Task 3: Pad input data and split into fixed-width words
  val paddedWidth = cycles * width
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)
  val dataSelect = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // Task 4: Implement handshaking and output word selection

  // Ready to accept new data when the cycle counter finishes transmitting all words
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Output is valid if input data is valid
  io.dataOut.valid := io.dataIn.valid

  // Select the serialized output word based on the cycle counter
  io.dataOut.bits := dataSelect(cycleCount)

  // Optional Debugging (Uncomment for simulation/debugging purposes)
  // printf(p"CycleCount: $cycleCount, Ready: ${io.dataIn.ready}, Valid: ${io.dataOut.valid}, Bits: ${io.dataOut.bits}\n")
}

