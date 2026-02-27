import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output validity: output is valid if at least one input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority selection: choose the first valid input channel (lowest index)
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      (channel.valid, index.U)
    }
  )

  // Data routing: connect the selected input channel's data to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input readiness: only the selected channel is ready when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (i.U === selectedChannel)
  }
}
