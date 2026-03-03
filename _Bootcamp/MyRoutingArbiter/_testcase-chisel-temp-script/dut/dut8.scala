import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be greater than 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // out.valid is high when any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the highest-priority valid channel (lowest index)
  private val idxWidth = math.max(1, log2Ceil(numChannels))
  val sel = PriorityMux(
    (0 until numChannels).map(i => io.in(i).valid -> i.U(idxWidth.W))
  )

  // Route selected channel data to output
  io.out.bits := io.in(sel).bits

  // Only selected input sees ready when output is ready and a valid transfer exists
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && io.out.valid && (sel === i.U(idxWidth.W))
  }
}
