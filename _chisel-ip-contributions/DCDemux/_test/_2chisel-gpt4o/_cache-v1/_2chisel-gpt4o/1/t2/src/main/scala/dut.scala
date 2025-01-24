import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels (n) must be greater than zero")

  // Calculate the width of the selector
  val selWidth = log2Ceil(n)

  // Define the input and output interface
  val io = IO(new Bundle {
    val sel = Input(UInt(selWidth.W))
    val c   = Flipped(DecoupledIO(data))
    val p   = Vec(n, DecoupledIO(data))
  })

  // Initialize all output channels `valid` to false
  io.p.foreach { channel =>
    channel.bits := io.c.bits // Default connection for bits
    channel.valid := false.B  // Default valid signal to false
  }

  // Set the default ready state for input `c` to false
  io.c.ready := false.B

  // Routing logic
  for (i <- 0 until n) {
    when(io.sel === i.U) {
      // When the selector matches the index, connect valid and ready signals
      io.p(i).valid := io.c.valid
      io.c.ready    := io.p(i).ready
    }
  }
}
