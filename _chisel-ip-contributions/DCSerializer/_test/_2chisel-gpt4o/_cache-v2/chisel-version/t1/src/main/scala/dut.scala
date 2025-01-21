import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate number of cycles required
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling division

  // Register to track the current cycle of serialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Vec to hold serialized data pieces
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Split input data into words and store in dataSelect
  for (i <- 0 until cycles) {
    val startIdx = i * width
    val endIdx = math.min(startIdx + width, totalBits)
    dataSelect(i) := (io.dataIn.bits.asUInt >> startIdx)(width - 1, 0)
  }

  // Default in/out signals
  io.dataIn.ready := false.B
  io.dataOut.valid := false.B
  io.dataOut.bits := dataSelect(cycleCount)

  when(io.dataIn.valid && io.dataOut.ready) {
    io.dataOut.valid := true.B
    when(io.dataOut.fire) {
      cycleCount := cycleCount + 1.U
      when(cycleCount === (cycles - 1).U) {
        cycleCount := 0.U
        io.dataIn.ready := true.B
      }
    }
  }
}
