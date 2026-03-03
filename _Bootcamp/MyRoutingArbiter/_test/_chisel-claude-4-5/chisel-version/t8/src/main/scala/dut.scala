import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: Set to true if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Select the channel number of the first valid input channel
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) =>
      channel.valid -> index.U
    }
  )

  // Data Routing: Route the data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Set ready signal for each input channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
