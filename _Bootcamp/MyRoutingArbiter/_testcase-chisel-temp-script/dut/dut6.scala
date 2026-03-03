import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be greater than 0")

  private val selWidth = math.max(1, log2Ceil(numChannels))

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // True when any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Index of highest-priority valid channel (lowest index wins)
  val selected = PriorityMux(
    (0 until numChannels).map(i => io.in(i).valid -> i.U(selWidth.W)) :+ (true.B -> 0.U(selWidth.W))
  )

  // Route selected channel data to output
  io.out.bits := io.in(selected).bits

  // Only selected input sees ready when output handshake can occur
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && io.out.valid && (selected === i.U(selWidth.W))
  }
}
