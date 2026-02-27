import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })
  
  // Output is valid if at least one input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)
  
  // Use PriorityMux to select the first valid channel
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )
  
  // Forward the data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits
  
  // Set ready signal for each input channel
  // Only the selected channel is ready when the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
