import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  // Define the IO interface
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c = Flipped(Decoupled(data))
    val p = Vec(n, Decoupled(data))
  })

  // Default initialization
  io.c.ready := false.B

  // Iterate over each output channel
  for (i <- 0 until n) {
    // Default state: output channels are invalid
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits // Data from input passed to all outputs

    // Set the logic for demultiplexing based on the selector signal
    when (i.U === io.sel) {
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    }
  }
}

