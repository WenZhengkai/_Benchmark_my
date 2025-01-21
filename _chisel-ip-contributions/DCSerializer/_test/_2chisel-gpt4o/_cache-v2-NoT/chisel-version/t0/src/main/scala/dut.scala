import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be a positive integer")
  require(data.getWidth > width, "Width must be less than the bit-width of input data")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val cycles = (data.getWidth + width - 1) / width  // ceiling of data width / word width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val start = i * width
    val end = math.min((i + 1) * width, data.getWidth)
    dataSelect(i) := io.dataIn.bits(start, end - 1).asUInt
  }

  // Mux for selecting the current word based on cycleCount
  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  // Increment cycle counter upon successful transmission
  when(io.dataOut.fire()) {
    cycleCount := cycleCount + 1.U
  }

  // Reset cycle counter when a new data transaction begins
  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }

  // Task 6: Combine and Integrate Logic
  // Additional logic is inherently integrated in the module design above.
}


