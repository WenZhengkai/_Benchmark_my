import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Output word width must be positive.")
  require(data.getWidth > width, "Output width must be less than data width for serialization.")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate total cycles needed for serialization
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // Cycle counter as a state register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Serialization logic: split data into parts of `width` and hold in a vector
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    dataSelect(i) := (io.dataIn.bits.asUInt >> (i * width)).asUInt
  }

  // Handshakes
  io.dataIn.ready := (cycleCount === (cycles - 1).U) & io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid
  
  // Select the output word based on the current cycle count
  io.dataOut.bits := dataSelect(cycleCount)

  // Cycle counter logic to increment when output is fired
  when (io.dataOut.fire) {
    when (cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  } .elsewhen (io.dataIn.fire) {
    cycleCount := 0.U
  }
}
