import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than zero.")
  require(data.getWidth > width, "Width must be less than the bit-width of the input data.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles required to serialize the input data
  val cycles = (data.getWidth + width - 1) / width

  // Cycle counter to track serialization progress
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Calculate padded width to fit the entire data in 'width'-bit chunks
  val paddedWidth = cycles * width

  // Pad the input data with zeroes (MSB) to make it a multiple of `width` bits
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)

  // Split the padded data into 'width'-bit chunks (Vec of width-bit UInt)
  val dataSelect = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // Handshaking logic for `io.dataIn`
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Handshaking logic for `io.dataOut`
  io.dataOut.valid := io.dataIn.valid
  io.dataOut.bits := dataSelect(cycleCount)

  // Cycle count update logic
  when(io.dataOut.fire) {
    when(cycleCount === (cycles - 1).U) {
      // Reset cycleCount for the next transaction
      cycleCount := 0.U
    }.otherwise {
      // Increment cycleCount to send the next chunk
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset cycleCount when a new transaction starts
  when(io.dataIn.fire) {
    cycleCount := 0.U
  }
}

