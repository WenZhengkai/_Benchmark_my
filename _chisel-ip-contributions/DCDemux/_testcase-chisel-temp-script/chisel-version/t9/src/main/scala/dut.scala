import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels must be greater than 0.")
  val selWidth = log2Ceil(n)

  val io = IO(new Bundle {
    val sel = Input(UInt(selWidth.W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })

  // Initialize all output channels to have invalid data
  for (i <- 0 until n) {
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits
  }

  // Default: input channel is not ready
  io.c.ready := false.B

  // Connect valid and ready handshake logic based on sel
  when(io.c.valid) {
    for (i <- 0 until n) {
      when(i.U === io.sel) {
        io.p(i).valid := io.c.valid
        io.c.ready := io.p(i).ready
      }
    }
  }
}

