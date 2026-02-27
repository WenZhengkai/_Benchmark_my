import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })
  
  // Create a vector of valid signals from all input channels
  val valids = io.in.map(_.valid)
  
  // Set output valid if at least one input channel is valid
  io.out.valid := valids.reduce(_ || _)
  
  // Use PriorityMux to select the first valid channel
  val selectedChannel = PriorityMux(
    valids.zipWithIndex.map { case (valid, index) => 
      (valid, index.U)
    }
  )
  
  // Route data from the selected input channel to the output
  io.out.bits := MuxLookup(
    selectedChannel,
    0.U, // Default value (should never be used if at least one channel is valid)
    io.in.zipWithIndex.map { case (channel, index) => 
      (index.U, channel.bits)
    }
  )
  
  // Set ready signals for input channels
  // Only the selected channel is ready when the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
