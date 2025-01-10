import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Width of the serialized output channel must be less than the input data width")
  require(width > 0, "Width must be greater than 0")
  
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))       // Input handshaking interface for input data
    val dataOut = Decoupled(UInt(width.W))     // Output handshaking interface for serialized data words
  })

  // Calculate the total number of cycles required for serialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling of dataWidth / width

  // Register for storing the current cycle count
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Register for storing the input data to be serialized
  val dataReg = RegInit(0.U(dataWidth.W))
  val active = RegInit(false.B) // Indicates if a transaction is actively being serialized

  // Generate a Vec to hold the serialized data chunks
  val dataSelect = VecInit.tabulate(cycles) { i =>
    val start = i * width
    val end = Math.min(start + width, dataWidth)
    dataReg(end - 1, start)
  }

  // Default outputs
  io.dataIn.ready := !active && io.dataOut.ready
  io.dataOut.bits := dataSelect(cycleCount)
  io.dataOut.valid := active

  when(io.dataIn.fire) {
    // Capture the input data to begin a new transaction
    dataReg := io.dataIn.bits.asUInt
    cycleCount := 0.U
    active := true.B
  }

  when(io.dataOut.fire) {
    // Move to the next cycle and continue serialization
    cycleCount := cycleCount + 1.U

    // End transaction if we've completed all cycles
    when(cycleCount === (cycles - 1).U) {
      active := false.B
      // Reset cycle count (optional but cleaner)
      cycleCount := 0.U
    }
  }
}
