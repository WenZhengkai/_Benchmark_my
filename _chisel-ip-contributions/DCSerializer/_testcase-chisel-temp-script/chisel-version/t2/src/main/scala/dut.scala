import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "Data width must be greater than serialization width.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataBits = data.getWidth
  val cycles = if (dataBits % width != 0) (dataBits / width) + 1 else dataBits / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))

  // Populate dataSelect with slices of input data
  for (i <- 0 until cycles) {
    val start = i * width
    val end = if (start + width > dataBits) dataBits else start + width
    dataSelect(i) := io.dataIn.bits.asUInt()(end - 1, start)
  }

  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := cycleCount === (cycles - 1).U && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  // Control Logic
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset cycle counter on new input transaction
  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}


