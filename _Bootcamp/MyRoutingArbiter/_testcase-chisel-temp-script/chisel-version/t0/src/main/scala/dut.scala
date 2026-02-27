import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output is valid if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the highest priority valid channel (lowest index)
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )

  // Route the data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Set ready signals for input channels
  // Only the selected channel is ready when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
