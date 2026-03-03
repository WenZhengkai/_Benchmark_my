import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output valid if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the lowest-indexed valid channel
  val selIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  )

  // Route data from selected channel to output
  io.out.bits := io.in(selIdx).bits

  // Ready only asserted for the selected channel, gated by out.ready
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && (selIdx === idx.U) && ch.valid
  }
}
