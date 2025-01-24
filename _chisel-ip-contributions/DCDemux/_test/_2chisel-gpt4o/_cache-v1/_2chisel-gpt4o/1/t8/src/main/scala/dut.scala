import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c   = Flipped(DecoupledIO(data))
    val p   = Vec(n, DecoupledIO(data))
  })

  // Initialize: Set all output channels to invalid by default
  for (i <- 0 until n) {
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits
  }
  
  // Default input ready signal to false
  io.c.ready := false.B

  // Demultiplex logic
  when(io.c.valid) {
    for (i <- 0 until n) {
      when(io.sel === i.U) {
        io.p(i).valid := io.c.valid
        io.c.ready := io.p(i).ready
      }
    }
  }
}

