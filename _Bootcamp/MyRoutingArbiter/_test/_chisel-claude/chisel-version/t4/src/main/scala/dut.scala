import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })
  
  // Check if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)
  
  // Create a priority selector to determine which valid channel to select
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )
  
  // Route the data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits
  
  // Set the ready signals for each input channel
  // Only the selected channel will be marked as ready if the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
