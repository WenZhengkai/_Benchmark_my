import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: out.valid is true if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Use PriorityMux to select the first valid input channel
  // Create a sequence of (valid signal, channel index) pairs
  val validIndexPairs = io.in.zipWithIndex.map { case (channel, idx) =>
    (channel.valid, idx.U)
  }
  val selectedChannel = PriorityMux(validIndexPairs)

  // Data Routing: Route data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Set ready signal for each input channel
  // Only the selected channel should be ready if output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U) && io.in(i).valid
  }
}
