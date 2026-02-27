import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // The output is valid if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Create a vector of channel valid signals
  val channelValids = VecInit(io.in.map(_.valid))
  
  // Select the first valid channel using PriorityMux
  // This returns the index of the highest priority (lowest-indexed) valid channel
  val selectedChannel = PriorityEncoder(channelValids)

  // Route the data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Set ready signals for input channels
  // Only the selected channel is ready when the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (i.U === selectedChannel)
  }
}
