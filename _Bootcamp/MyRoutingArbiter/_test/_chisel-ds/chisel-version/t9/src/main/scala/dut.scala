import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output validity: OR reduction of all input valid signals
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority selection: Select the first valid channel
  val selectedChannel = PriorityMux(io.in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) })

  // Data routing: Route the selected channel's data to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input readiness: Only the selected channel is ready if the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}

// Optional: A companion object to simplify module instantiation
object dut {
  def apply(numChannels: Int): dut = new dut(numChannels)
}
