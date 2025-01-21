import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed to serialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // equivalent to ceil(dataWidth / width)

  // Cycle counter to track serialization progress
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // A vector to select the correct word to output based on the current cycle
  val dataVec = Wire(Vec(cycles, UInt(width.W)))

  // Split input data into words of `width` bits each
  for (i <- 0 until cycles) {
    val startBit = i * width
    val endBit = startBit + width min dataWidth
    dataVec(i) := io.dataIn.bits.asUInt()(endBit - 1, startBit)
  }

  // Output logic
  io.dataOut.bits := dataVec(cycleCount)

  // Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  when(io.dataOut.fire) {
    cycleCount := cycleCount + 1.U
  }

  when(io.dataIn.fire) {
    cycleCount := 0.U
  }
}

