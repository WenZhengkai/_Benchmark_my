import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0 && width < data.getWidth, "Width must be greater than 0 and less than the bit-width of the input data.")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of serialization cycles
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) (dataWidth / width) + 1 else dataWidth / width
  
  // Cycle counter register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Data selection and storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  // Populate the dataSelect with slices of data
  for (i <- 0 until cycles) {
    val startBit = i * width
    val endBit = (i + 1) * width - 1
    val sliceWidth = if (endBit < dataWidth) width else dataWidth - startBit
    dataSelect(i) := io.dataIn.bits.asUInt()(startBit + sliceWidth - 1, startBit)
  }

  // Default output assignments
  io.dataOut.bits := dataSelect(cycleCount)
  io.dataOut.valid := io.dataIn.valid && cycleCount < cycles.U

  // Handshaking logic for data input
  io.dataIn.ready := cycleCount === (cycles - 1).U && io.dataOut.ready

  // Handshaking logic and cycle count update
  when(io.dataOut.fire()) {
    cycleCount := cycleCount + 1.U
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }
  }

  // Reset cycle count on new input transaction
  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}
