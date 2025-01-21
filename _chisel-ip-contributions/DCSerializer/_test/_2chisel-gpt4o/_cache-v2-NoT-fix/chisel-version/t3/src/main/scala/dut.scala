import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be positive")
  require(data.getWidth > width, "Width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataBitWidth = data.getWidth
  val cycles = if (dataBitWidth % width != 0) dataBitWidth / width + 1 else dataBitWidth / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  when(io.dataOut.fire()) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val startIdx = i * width
    val endIdx = math.min(startIdx + width, dataBitWidth)
    dataSelect(i) := io.dataIn.bits.asUInt()(endIdx-1, startIdx)
  }
  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := ((cycleCount === (cycles - 1).U) && io.dataOut.ready)

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

}

