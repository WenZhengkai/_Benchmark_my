import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  val dataWidth = data.getWidth
  require(width < dataWidth, "Output width must be less than input data width")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  val cycles = (dataWidth + width - 1) / width // Ceiling division to handle remainders
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Splitting input data into words of size 'width'
  for(i <- 0 until cycles) {
    val lowerBound = i * width
    val upperBound = ((i + 1) * width) min dataWidth
    dataSelect(i) := io.dataIn.bits.asUInt()(upperBound-1, lowerBound)
  }

  // Selecting the current word based on `cycleCount`
  io.dataOut.bits := dataSelect(cycleCount)

  // Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  when (io.dataIn.fire()) {
    cycleCount := 0.U
  }.elsewhen(io.dataOut.fire()) {
    cycleCount := cycleCount + 1.U
  }

  // Reset cycleCounter and setup for next transaction
  when (io.dataIn.fire() && (cycles > 1.U)) {
    cycleCount := 0.U
  }
}

