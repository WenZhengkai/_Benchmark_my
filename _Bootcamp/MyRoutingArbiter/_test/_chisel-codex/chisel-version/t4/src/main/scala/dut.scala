import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be greater than 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output is valid if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the highest-priority valid channel (lowest index)
  private val selWidth = math.max(1, log2Ceil(numChannels))
  val selectedIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U(selWidth.W) }
  )

  // Route selected channel data to output
  io.out.bits := io.in(selectedIdx).bits

  // Only the selected input sees ready when output is ready and transfer is possible
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && io.out.valid && (selectedIdx === idx.U)
  }
}
