import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // out.valid is high when any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the first valid channel (lowest index has highest priority)
  private val selWidth = math.max(1, log2Ceil(numChannels))
  val selectedIdx = PriorityMux(
    io.in.indices.map(i => io.in(i).valid -> i.U(selWidth.W))
  )

  // Route selected channel's data to output
  io.out.bits := Mux(io.out.valid, io.in(selectedIdx).bits, 0.U)

  // Only the selected input sees ready when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && io.out.valid && (selectedIdx === i.U)
  }
}
