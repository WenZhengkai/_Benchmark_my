import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output validity: true if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority select: index of the first valid channel (lowest index wins)
  val selIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U(log2Ceil(numChannels).W) }
  )

  // Data routing from the selected channel
  io.out.bits := io.in(selIdx).bits

  // Input readiness: only the selected valid channel is ready when out is ready
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && (selIdx === idx.U)
  }
}
