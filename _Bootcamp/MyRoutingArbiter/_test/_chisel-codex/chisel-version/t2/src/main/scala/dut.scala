import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // True when any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Index of the first valid input channel (lowest index has highest priority)
  val selectedIdx = PriorityMux(
    (0 until numChannels).map(i => io.in(i).valid -> i.U(log2Ceil(numChannels).W))
  )

  // Route selected input data to output
  io.out.bits := Mux(io.out.valid, io.in(selectedIdx).bits, 0.U)

  // Only selected input is ready when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && io.out.valid && (selectedIdx === i.U)
  }
}
