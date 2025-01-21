import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than the input data width.")
  
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Calculate number of cycles needed

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Use a Wire to convert from Data to UInt
  val inputDataAsUInt = Wire(UInt(dataWidth.W))
  inputDataAsUInt := io.dataIn.bits.asUInt

  // Slice the input data into fixed width words
  for (i <- 0 until cycles) {
    val lowerBound = i * width
    val upperBound = math.min((i + 1) * width, dataWidth)
    dataSelect(i) := inputDataAsUInt(upperBound - 1, lowerBound)
  }

  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}