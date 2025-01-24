import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })

  // Task 2: Initialize Ready Signal
  io.c.ready := false.B

  // Iterate over Output Channels
  for (i <- 0 until n) {
    // Task 4: Assign Data to Output Channels
    io.p(i).bits := io.c.bits
    
    // Task 5: Implement Selection Logic
    when (i.U === io.sel) {
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    } .otherwise {
      // Task 6: Inactivate Non-Selected Channels
      io.p(i).valid := false.B
    }
  }
}
