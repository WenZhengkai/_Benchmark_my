import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  private val selWidth = math.max(1, log2Ceil(numChannels))

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output is valid if any input is valid.
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the first valid channel (lowest index has highest priority).
  val selectedChannel = PriorityMux(
    (0 until numChannels).map(i => io.in(i).valid -> i.U(selWidth.W))
  )

  // Route data from the selected channel.
  io.out.bits := io.in(selectedChannel).bits

  // Only the selected input sees ready when output is ready and a valid transfer is possible.
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && io.out.valid && (selectedChannel === i.U)
  }
}
