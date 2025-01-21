import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(data.getWidth > width, "Data width must be greater than output width")

  // Number of cycles needed to serialize the data
  val cycles = if (data.getWidth % width != 0) data.getWidth / width + 1 else data.getWidth / width

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Register to keep track of current cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Split the input data into words of size width
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    dataSelect(i) := io.dataIn.bits.asUInt()((i + 1) * width - 1, i * width)
  }

  // Default output values
  io.dataOut.bits := 0.U
  io.dataOut.valid := false.B
  io.dataIn.ready := false.B

  // Send words one by one when input data is valid and output is ready
  when(io.dataIn.valid && io.dataOut.ready) {
    io.dataOut.bits := dataSelect(cycleCount)
    io.dataOut.valid := true.B

    when(io.dataOut.fire()) {
      when(cycleCount === (cycles - 1).U) {
        cycleCount := 0.U
        io.dataIn.ready := true.B // Ready to accept new data once the current transaction is complete
      }.otherwise {
        cycleCount := cycleCount + 1.U
      }
    }
  }
}
