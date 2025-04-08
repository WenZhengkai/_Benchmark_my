import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Output word width must be greater than zero")
  require(width < data.getWidth, "Output width must be smaller than the input data width")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data)) // Input data to serialize
    val dataOut = Decoupled(UInt(width.W)) // Serialized output data
  })

  // Compute number of cycles required for serialization
  val totalWidth = data.getWidth
  val cycles = (totalWidth + width - 1) / width // Ceiling division to handle non-even splits

  // Register to track the current serialization cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Calculate the padded width and pad the input data if necessary
  val paddedWidth = cycles * width
  val paddedData = Cat(0.U((paddedWidth - totalWidth).W), io.dataIn.bits.asUInt)

  // Split the padded data into a vector of fixed-width words
  val dataSelect = VecInit.tabulate(cycles)(i => paddedData((i + 1) * width - 1, i * width))

  // Handshaking logic for input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Handshaking logic for output
  io.dataOut.valid := io.dataIn.valid

  // Output the current serialized word
  io.dataOut.bits := dataSelect(cycleCount)

  // Cycle count update logic
  when(io.dataOut.fire) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U // Reset cycle count after all words have been sent
    }.otherwise {
      cycleCount := cycleCount + 1.U // Increment for the next word
    }
  }

  // Reset cycle count when a new input transaction starts
  when(io.dataIn.fire) {
    cycleCount := 0.U
  }
}

