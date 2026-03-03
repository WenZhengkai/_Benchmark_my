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
  val selectedIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  )

  // Route data from selected channel to output
  io.out.bits := io.in(selectedIdx).bits

  // Only the selected channel is ready when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedIdx === i.U)
  }
}
