import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "Data width must be greater than serialized output width.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val cycles = (data.getWidth + width - 1) / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  when(io.dataOut.fire()) {
    cycleCount := cycleCount + 1.U
  }

  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  for (i <- 0 until cycles) {
    val lower = i * width
    val upper = math.min((i + 1) * width, data.getWidth) // ensure we don't exceed the data width
    dataSelect(i) := io.dataIn.bits.asUInt()(upper - 1, lower)
  }

  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  // Optional: end the transaction when the last word has been sent
  // (manage transaction completion externally as needed)
}

