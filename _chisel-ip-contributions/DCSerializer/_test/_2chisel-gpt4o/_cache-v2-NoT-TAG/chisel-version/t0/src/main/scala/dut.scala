import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  
  require(width > 0, "width must be greater than 0")
  require(width < data.getWidth, "width must be less than the input data's bitwidth")
  
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))         // Input data handshaking interface
    val dataOut = Decoupled(UInt(width.W))        // Serialized data output channel
  })

  // Task 1: Compute number of cycles required to serialize the input data
  val cycles = (data.getWidth + width - 1) / width // Ceiling division to determine number of chunks
  
  // Task 2: Cycle counter logic
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W)) // Register to track serialization progress

  when(io.dataOut.fire) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U) // Reset counter or increment
  }.elsewhen(io.dataIn.fire) {
    cycleCount := 0.U // Start new input transaction
  }

  // Task 3: Split input data
  // Compute padded data width, pad input data, and split into chunks
  val paddedWidth = cycles * width                    // Padded width
  val paddedData  = Cat(0.U((paddedWidth - data.getWidth).W), io.dataIn.bits.asUInt) // Pad MSBs with zeros
  val dataSelect  = VecInit.tabulate(cycles)(i => paddedData(i * width + width - 1, i * width)) // Chunks of width bits

  // Task 4: Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready // Ready for new data at end of current transaction
  io.dataOut.valid := io.dataIn.valid                                    // Output valid state depends on input validity
  io.dataOut.bits := dataSelect(cycleCount)                             // Select the appropriate word for current cycle
  
  // Debugging print statements (optional, remove or comment out in production)
  // printf(p"Cycle Count: $cycleCount, Input Ready: ${io.dataIn.ready}, Output Valid: ${io.dataOut.valid}\n")
  // printf(p"Current Output Bits: ${io.dataOut.bits}\n")

}
