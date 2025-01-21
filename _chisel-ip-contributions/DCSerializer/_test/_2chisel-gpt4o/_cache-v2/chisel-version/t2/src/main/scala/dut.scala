import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than input data width.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed to serialize the data
  // Width-data should be round-up division
  val bitsToSerialize = data.getWidth
  val cycles = if (bitsToSerialize % width == 0) bitsToSerialize / width
               else (bitsToSerialize / width) + 1

  // Create a vector to hold split data words
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Register to keep track of the current cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  when(io.dataOut.fire()) {
    cycleCount := cycleCount + 1.U
    // Reset cycleCount to zero at the end of the transaction
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }
  }
  
  // Divide the input data into words of size `width`
  for(i <- 0 until cycles) {
    dataSelect(i) := (io.dataIn.bits.asUInt >> (i * width).U) & ((BigInt(1) << width) - 1).U
  }

  // Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid
  io.dataOut.bits := dataSelect(cycleCount)

  when(io.dataIn.fire()) {
    cycleCount := 0.U // Reset on new transaction
  }
}

