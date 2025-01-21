import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  // Check that the width is less than the bit-width of the input data
  require(width < data.getWidth, "Width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed for serialization
  val cycles = (data.getWidth + width - 1) / width

  // Register to track the current cycle of serialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Split input data into words of size `width`, stored in a Vec
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val startBit = i * width
    val endBit = (i * width) + width - 1
    dataSelect(i) := io.dataIn.bits.asUInt()(endBit, startBit)
  }

  // Default connection to outputs
  io.dataOut.valid := io.dataIn.valid && cycleCount < (cycles.U)
  io.dataOut.bits := dataSelect(cycleCount)

  // Handshaking behavior: input ready when the current series has been completely serialized
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Cycle counter logic
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      // Reset cycle count for a new transaction
      cycleCount := 0.U
    }.otherwise {
      // Increment cycle count for each valid transmission
      cycleCount := cycleCount + 1.U
    }
  }
}

