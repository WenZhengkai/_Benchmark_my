import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: Check if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Select the index of the first valid input channel
  val selectedChannel = PriorityMux(
    io.in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) }
  )

  // Data Routing: Route data from the selected channel to output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Set ready signal for each input channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}
