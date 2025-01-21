import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, val width: Int) extends Module {
  require(width < data.getWidth, "Output word width must be less than the bit width of the input data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles required for serialization
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) (dataWidth / width) + 1 else dataWidth / width

  // Cycle counter
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Data select logic: slice the input data into width-bit words
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val startIdx = i * width
    val endIdx = math.min(startIdx + width, dataWidth)
    dataSelect(i) := io.dataIn.bits.asUInt()(endIdx - 1, startIdx)
  }

  // Set output logic
  io.dataOut.bits := dataSelect(cycleCount)

  // Handshaking mechanism
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  // Cycle counter logic
  when(io.dataOut.fire) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }

  // Reset cycle count when a new transaction is acknowledged
  when(io.dataIn.fire) {
    cycleCount := 0.U
  }
}

