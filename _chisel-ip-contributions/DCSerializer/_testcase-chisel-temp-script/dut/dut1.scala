import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(data.getWidth > width, "Width of output channel must be less than the width of the input data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data)) // Input interface for the data to be serialized
    val dataOut = Decoupled(UInt(width.W)) // Output interface for serialized data
  })

  // Calculate number of serialization cycles
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width // Ceiling of dataWidth / width
  
  // Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Tracks current cycle of serialization
  val active = RegInit(false.B) // Indicates if serialization is in progress
  
  // Convert the input data to a UInt for serialization
  val dataVec = Wire(Vec(cycles, UInt(width.W)))
  val inputData = Reg(data)
  
  // Break the input data into smaller words of size `width`
  for (i <- 0 until cycles) {
    val startIdx = i * width
    val endIdx = math.min((i + 1) * width, dataWidth) - 1
    dataVec(i) := inputData.asUInt()(endIdx, startIdx)
  }
  
  // Handshaking logic
  io.dataIn.ready := !active && io.dataOut.ready // Accept new data when idle and output is ready
  io.dataOut.valid := active // Output is valid only when serialization is active
  io.dataOut.bits := dataVec(cycleCount) // Output the current serialized word

  when(io.dataIn.fire) {
    // Start a new serialization transaction
    inputData := io.dataIn.bits
    cycleCount := 0.U
    active := true.B
  }.elsewhen(io.dataOut.fire && active) {
    // During serialization, advance the cycle count
    when(cycleCount === (cycles - 1).U) {
      active := false.B // End serialization once all cycles are done
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
