import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Check if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Create a priority mux to select the first valid channel
  val selectChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )

  // Route the selected channel's data to the output
  io.out.bits := io.in(selectChannel).bits

  // Set ready signals for each input channel
  // Only the selected channel is ready when the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectChannel === i.U)
  }
}
