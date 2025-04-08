import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "The output width must be less than the input data width")

  // IO Definition
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))  // Input data (handshakes for readiness)
    val dataOut = Decoupled(UInt(width.W)) // Serialized output words
  })

  // Compute the number of cycles needed for serialization
  val cycles = (data.getWidth + width - 1) / width

  // Cycle counter register
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))

  // Compute the padded width
  val paddedWidth = cycles * width

  // Pad the input data to paddedWidth and split into chunks of 'width' bits
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)
  val dataSelect = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width))

  // Handshaking logic
  // Drive io.dataIn.ready when ready to receive new data
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Drive io.dataOut.valid based on input validity and output readiness
  io.dataOut.valid := io.dataIn.valid

  // Select the word to output based on the current cycle count
  io.dataOut.bits := dataSelect(cycleCount)

  // Update the cycle counter
  when(io.dataOut.fire) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }

  // Reset the cycle counter when a new input transaction starts
  when(io.dataIn.fire) {
    cycleCount := 0.U
  }  
}
