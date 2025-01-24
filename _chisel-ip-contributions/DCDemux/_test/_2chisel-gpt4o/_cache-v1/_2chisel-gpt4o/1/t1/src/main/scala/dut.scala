import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, s"Number of output channels (n) should be greater than 0, but got $n")
  val log2n = log2Ceil(n)

  val io = IO(new Bundle {
    val sel = Input(UInt(log2n.W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })

  // Initialize all `p` output channels to default values
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits
    io.p(i).valid := false.B
  }

  // Ready signal for input is false by default
  io.c.ready := false.B

  // Logic for demultiplexing
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    }
  }
}

