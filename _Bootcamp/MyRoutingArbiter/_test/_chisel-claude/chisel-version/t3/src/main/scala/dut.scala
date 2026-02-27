// package arbitration

import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output valid if at least one input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Use PriorityMux to select the first valid channel
  val validMask = io.in.map(_.valid)
  val channelIndices = (0 until numChannels).map(_.U)
  val selectedChannel = PriorityMux(validMask.zip(channelIndices))

  // Route data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Set ready for the selected channel only
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (i.U === selectedChannel)
  }
}
