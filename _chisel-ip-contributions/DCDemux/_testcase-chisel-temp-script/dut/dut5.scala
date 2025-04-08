import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))   // Selector signal
    val c = Flipped(DecoupledIO(data))    // Input channel
    val p = Vec(n, DecoupledIO(data))     // Output channels
  })

  // Task 1: Initialize input ready signal
  io.c.ready := false.B

  // Task 2: Connect input data to all output channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits // Route input data to all outputs
  }

  // Task 3: Conditionally set valids and update ready signal
  for (i <- 0 until n) {
    when(i.U === io.sel) {
      // Selected output channel
      io.p(i).valid := io.c.valid   // Propagate input valid signal to the selected output
      io.c.ready := io.p(i).ready  // Input ready depends on the chosen output's ready signal
    } .otherwise {
      // Non-selected output channels
      io.p(i).valid := false.B     // Disable unselected outputs
    }
  }
}


