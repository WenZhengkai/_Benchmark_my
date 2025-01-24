import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, n: Int) extends Module {
  require(n > 0, "Number of output channels must be greater than zero")
  
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
    val c = Flipped(DecoupledIO(data))
    val p = Vec(n, DecoupledIO(data))
  })

  // Task 2: Initialize Ready Signal
  // Initialize input channel to not ready by default
  io.c.ready := false.B

  // Task 3: Iterate Over Output Channels
  // Loop through each output channel
  for (i <- 0 until n) {
    // Task 4: Assign Data to Output Channels
    // Forward data from the input channel to each output channel
    io.p(i).bits := io.c.bits

    // Task 5: Implement Selection Logic
    when (i.U === io.sel) {
      // If the current index matches the selector,
      // The output channel becomes valid and input is ready when selected channel is ready
      io.p(i).valid := io.c.valid
      io.c.ready := io.p(i).ready
    } .otherwise {
      // Task 6: Inactivate Non-Selected Channels
      // Channels not selected get a false valid
      io.p(i).valid := false.B
    }
  }
}

