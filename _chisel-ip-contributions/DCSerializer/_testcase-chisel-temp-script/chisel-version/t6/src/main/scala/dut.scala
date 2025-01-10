import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "Output width must be less than input data width")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed to serialize the input data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width
  require(cycles > 1, "Need more than one cycle to serialize")

  // Register to keep track of the current cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Create a vector to hold the serialized words
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Split the input data into multiple words of size `width`
  for (i <- 0 until cycles) {
    val bitRangeStart = i * width
    val bitRangeEnd = math.min(bitRangeStart + width, dataWidth)
    dataSelect(i) := io.dataIn.bits.asUInt()(bitRangeEnd - 1, bitRangeStart)
  }

  // Cycle counter logic
  when(io.dataOut.fire) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }
  
  // Output logic
  io.dataOut.bits := dataSelect(cycleCount)
  io.dataOut.valid := io.dataIn.valid

  // Ready/valid handshake logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  when(io.dataIn.fire) {
    cycleCount := 0.U
  }
}

