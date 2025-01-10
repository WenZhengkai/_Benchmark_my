import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels must be greater than 0")
  
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })
  
  // Default assignments
  io.c.ready := false.B
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits
    io.p(i).valid := false.B
  }
  
  // Demultiplex logic
  when(io.c.valid) {
    // Set the selected output channel to valid
    io.p(io.sel).valid := true.B
    // Update the ready signal of the input channel according to the selected output
    io.c.ready := io.p(io.sel).ready
  }

  // Ensure that non-selected outputs remain invalid
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      io.p(i).valid := io.c.valid
    }.otherwise {
      io.p(i).valid := false.B
    }
  }
}


