import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Check if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)
  
  // Task 2: Implement Priority Selection using PriorityMux
  // Create a PriorityMux to find the index of the first valid channel
  val validSignals = io.in.map(_.valid)
  val channelIndices = VecInit((0 until numChannels).map(_.U))
  val selectedChannel = PriorityMux(validSignals, channelIndices)

  // Task 3: Implement Data Routing
  // Route data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Implement Input Readiness Logic
  // Set each input channel's ready signal
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}

