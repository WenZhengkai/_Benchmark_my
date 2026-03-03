import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // out.valid is true when any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select first valid channel (lowest index has highest priority)
  val chosen = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U(log2Ceil(numChannels).W) }
  )

  // Route selected input data to output
  io.out.bits := io.in(chosen).bits

  // Only selected channel is ready when output is ready and transfer is possible
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && io.out.valid && (chosen === idx.U)
  }
}
