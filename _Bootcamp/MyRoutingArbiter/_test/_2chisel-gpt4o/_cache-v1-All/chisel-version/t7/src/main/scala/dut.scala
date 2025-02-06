import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Set the `out.valid` signal to true if at least one of the input channels is valid.
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Select the channel index of the first valid input channel using a PriorityMux.
  val validIndices = io.in.zipWithIndex.map { case (in, idx) => (in.valid, idx.U) }
  val selectedChannel = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  // Route the data from the selected input channel to the output.
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Implement Input Readiness Logic
  // Set each input channel's `ready` signal based on the selected channel index and output readiness.
  for (i <- 0 until numChannels) {
    io.in(i).ready := (io.out.ready && (selectedChannel === i.U))
  }
}

