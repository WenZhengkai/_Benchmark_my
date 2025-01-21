import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "The output width must be less than the input data width.")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))  // Input data to serialize
    val dataOut = Decoupled(UInt(width.W)) // Serialized output
  })

  // Calculate the total number of cycles required to serialize the input
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling of (dataWidth / width)

  // State tracking registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val activeTransaction = RegInit(false.B)

  // Internal storage for the sliced data
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val start = i * width
    val end = Math.min(start + width, dataWidth)
    dataSelect(i) := data.asUInt()(end - 1, start) // Select slices of size `width`
  }

  // Default output values
  io.dataIn.ready := false.B
  io.dataOut.valid := false.B
  io.dataOut.bits := 0.U

  // Serialization state machine
  when(activeTransaction) {
    // During active serialization

    // Drive output when valid
    io.dataOut.bits := dataSelect(cycleCount)
    io.dataOut.valid := true.B

    when(io.dataOut.fire) { // When the current word has been accepted by the downstream
      when(cycleCount === (cycles - 1).U) {
        // Final cycle completed, transaction done
        activeTransaction := false.B
        cycleCount := 0.U
        io.dataIn.ready := true.B
      } .otherwise {
        // Move to the next cycle
        cycleCount := cycleCount + 1.U
      }
    }
  } .otherwise {
    // Waiting for new transaction
    io.dataIn.ready := true.B

    when(io.dataIn.fire) { // A new transaction begins
      activeTransaction := true.B
      cycleCount := 0.U
    }
  }
}

