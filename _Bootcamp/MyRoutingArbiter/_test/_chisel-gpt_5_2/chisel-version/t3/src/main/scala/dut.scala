import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output is valid if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Pick the lowest-index valid channel
  val selIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  )

  // Route data from selected channel to output
  io.out.bits := io.in(selIdx).bits

  // Only the selected channel participates in the handshake
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selIdx === i.U)
  }
}
