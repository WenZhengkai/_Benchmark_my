import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0.")
  require(width < data.getWidth, "Width must be less than the bit-width of the input data.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data)) // Input data handshaking interface
    val dataOut = Decoupled(UInt(width.W)) // Output serialized data handshaking interface
  })

  // Task 1: Calculating the number of cycles required to serialize the input data
  val cycles = (data.getWidth + width - 1) / width

  // Task 2: Cycle counter logic to track serialization progress
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))

  // Task 3: Data padding and splitting into width-chunked words
  val paddedWidth = cycles * width
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt)
  val dataSelect = VecInit.tabulate(cycles) { i =>
    paddedData(i * width + width - 1, i * width)
  }

  // Output word selection based on the cycle count
  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking logic for I/O control
  val isLastCycle = cycleCount === (cycles - 1).U

  // `ready` signal is driven when the module is ready for new data
  io.dataIn.ready := isLastCycle && io.dataOut.ready

  // `valid` signal propagates the input `valid` status
  io.dataOut.valid := io.dataIn.valid

  // Update cycle counter - reset to 0 for new input or increment with `fire`
  when(io.dataOut.fire) {
    cycleCount := Mux(isLastCycle, 0.U, cycleCount + 1.U)
  }
}
