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
  val chosenIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, i) => (ch.valid, i.U) }
  )

  // Route data from chosen channel
  io.out.bits := io.in(chosenIdx).bits

  // Ready only for the chosen channel (and only when output is ready)
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (chosenIdx === i.U) && io.in(i).valid
  }
}
