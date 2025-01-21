import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than input data width")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) (dataWidth / width) + 1 else dataWidth / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  // Using a Vec to hold the sliced words of the input data
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val start = i * width
    val end = (i + 1) * width - 1
    dataSelect(i) := io.dataIn.bits.asUInt()(end.min(dataWidth-1), start)
  }

  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  // Task 6: Combine and Integrate Logic
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }.elsewhen(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}
