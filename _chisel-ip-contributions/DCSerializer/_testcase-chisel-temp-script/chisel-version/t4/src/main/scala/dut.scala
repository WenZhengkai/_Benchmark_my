import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(width < data.getWidth, "Width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))                // Input data to be serialized
    val dataOut = Decoupled(UInt(width.W))               // Serialized output data
  })

  // Task 1: Compute number of serialization cycles
  val cycles = (data.getWidth + width - 1) / width       // Ceiling division to determine cycles

  // Task 2: Cycle counter logic
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))  // Register for tracking serialization progress

  when(io.dataOut.fire) {                                // Increment cycle counter on output handshake
    cycleCount := cycleCount + 1.U
  }
  when(io.dataIn.fire) {                                 // Reset cycle counter for new transaction
    cycleCount := 0.U
  }

  // Task 3: Padding and splitting data for serialization
  val paddedWidth = cycles * width                       // Calculate padded width
  val paddedData = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt) // Pad input data with MSB zeros
  val dataSelect = VecInit.tabulate(cycles)(i =>         // Split the data into width-bit chunks
    paddedData((i + 1) * width - 1, i * width)
  )

  // Task 4: Handshaking logic for input/output control
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready // Ready for new input when last word is sent
  io.dataOut.valid := io.dataIn.valid                                     // Input validity propagates to output
  io.dataOut.bits := dataSelect(cycleCount)                              // Select output word based on cycleCount
}

// Example instantiation (Optional Example for Reference)
// val serializer = Module(new dut(UInt(64.W), 8))
// serializer.io.dataIn <> someProducer
// serializer.io.dataOut <> someConsumer
