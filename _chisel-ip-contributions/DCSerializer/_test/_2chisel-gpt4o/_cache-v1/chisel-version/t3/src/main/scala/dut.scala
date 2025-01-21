import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(data.getWidth > width, "Output width must be less than input data width")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed to serialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling division

  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataReg = Reg(data)

  // Ready to accept new data when we've completed serializing the current one
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Load new data when input is fired
  when(io.dataIn.fire()) {
    dataReg := io.dataIn.bits
    cycleCount := 0.U
  }

  // Output valid when we're in the process of serialization
  io.dataOut.valid := io.dataIn.valid

  // Create a Vec to store individual slices of the input data
  val dataVec = VecInit(Seq.tabulate(cycles) { i =>
    val startBit = i * width
    val endBit = math.min(startBit + width, dataWidth)
    dataReg.asUInt()(endBit - 1, startBit)
  })

  // Select the correct slice of data to output
  io.dataOut.bits := dataVec(cycleCount)

  // Increment cycle counter when output fires and is valid
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U // Reset cycle count when all cycles are done
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
