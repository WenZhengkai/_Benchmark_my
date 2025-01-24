import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels must be greater than zero")
  
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })

  // Initialize all outputs
  for (i <- 0 until n) {
    io.p(i).valid := false.B
    io.p(i).bits := io.c.bits  // common assignment to all outputs
  }

  // Drive the selected output
  io.p(io.sel).valid := io.c.valid
  io.c.ready := io.p(io.sel).ready

  // When the selected channel is ready and input is valid, set output ready to TRUE
  when(io.c.valid && io.p(io.sel).ready) {
    io.c.ready := true.B
  } .otherwise {
    io.c.ready := false.B
  }

  // Ensure unselected outputs are not valid
  for (i <- 0 until n) {
    when(i.U =/= io.sel) {
      io.p(i).valid := false.B
    }
  }
}


