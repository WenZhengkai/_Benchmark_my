import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c   = Flipped(DecoupledIO(data))
    val p   = Vec(n, DecoupledIO(data))
  })

  // Default behavior: all output channels are invalid
  for (i <- 0 until n) {
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits
  }

  // Initialize the ready signal of the input channel 'c' to false
  io.c.ready := false.B

  // Iterate over output channels and set the corresponding valid and ready signals
  for (i <- 0 until n) {
    when (i.U === io.sel) {
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    }
  }
}

