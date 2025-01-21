import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, s"The width parameter ($width) must be less than the bit-width of the input data (${data.getWidth}).")
  
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles needed
  val cycles = WireInit((data.getWidth + width - 1) / width)

  // Create a register for the cycle count
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Split the data into words of size `width`
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  for (i <- 0 until cycles) {
    val start = i * width
    val end = math.min((i + 1) * width, data.getWidth) - 1
    dataSelect(i) := io.dataIn.bits.asUInt()(end, start)
  }

  // Output logic
  io.dataOut.bits := dataSelect(cycleCount)
  io.dataOut.valid := io.dataIn.valid

  // Handshaking logic
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  when(io.dataOut.fire) {
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }
  
  when (io.dataIn.fire) {
    cycleCount := 0.U
  }
}
