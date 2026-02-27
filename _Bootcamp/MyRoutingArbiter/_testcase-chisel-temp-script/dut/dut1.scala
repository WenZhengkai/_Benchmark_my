import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })
  
  // Determine if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)
  
  // Create a priority selection for the valid channels
  // The PriorityMux will select the lowest-indexed valid channel
  val selectedChannelIndex = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )
  
  // Route the selected channel's data to the output
  io.out.bits := io.in(selectedChannelIndex).bits
  
  // Set ready signals for input channels
  // Only the selected channel will be marked as ready if the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannelIndex === i.U)
  }
}
