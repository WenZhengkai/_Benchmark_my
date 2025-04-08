import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "The number of outputs (n) must be greater than 0")

  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W)) // Selector signal
    val c = Flipped(Decoupled(data)) // Input channel (Flipped DecoupledIO)
    val p = Vec(n, Decoupled(data)) // Output channels
  })

  // Task 1: Initialize Input Ready Signal
  io.c.ready := false.B

  // Task 2: Connect Input Data to All Output Channels
  for (i <- 0 until n) {
    io.p(i).bits := io.c.bits
  }

  // Task 3: Conditionally Set Valids and Update Ready Signal
  for (i <- 0 until n) {
    when(i.U === io.sel) { // When channel `i` is selected
      io.p(i).valid := io.c.valid // Propagate input validity
      io.c.ready := io.p(i).ready // Propagate output readiness to input
    }.otherwise { // For all other channels
      io.p(i).valid := false.B // Disable output valid
    }
  }
}

