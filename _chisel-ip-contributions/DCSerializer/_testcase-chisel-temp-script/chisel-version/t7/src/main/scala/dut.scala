import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than zero")
  require(data.getWidth > width, "Data width must be greater than serialized output width")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) (dataWidth / width) + 1 else dataWidth / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Populate dataSelect with slices of input data
  for (i <- 0 until cycles) {
    val startBit = i * width
    val endBit = math.min(startBit + width, dataWidth) - 1
    dataSelect(i) := io.dataIn.bits.asUInt()(endBit, startBit)
  }

  // Select the appropriate word from dataSelect for output
  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4 and 5: Handshaking Logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  // Task 2: Cycle Counter Logic continued
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


