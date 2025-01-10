import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "The width of the serialized output channel must be narrower than the input data width.")

  // Calculate the number of cycles required for serialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Equivalent to ceil(dataWidth / width)

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Register to track the current cycle of serialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Splitting the input data into a vector of smaller words
  val dataWords = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val start = i * width
    val end = start + width - 1
    dataWords(i) := data.asUInt()(end min (dataWidth-1), start)
  }

  // Output logic
  io.dataOut.bits := dataWords(cycleCount)

  // Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  // Cycle counter logic
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset cycle count when a new transaction is started
  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}

