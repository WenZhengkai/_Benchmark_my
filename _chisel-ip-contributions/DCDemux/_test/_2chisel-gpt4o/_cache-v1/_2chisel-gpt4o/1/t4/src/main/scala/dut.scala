import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than 0")

  val log2Ceil_n = log2Ceil(n)

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil_n.W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })
  
  // Initial busy signal for input channel
  io.c.ready := false.B

  // Iterating over output channels
  for (i <- 0 until n) {
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits

    when (io.sel === i.U) {
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    }
  }
}

