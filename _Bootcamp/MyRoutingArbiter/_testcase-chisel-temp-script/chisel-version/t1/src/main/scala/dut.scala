import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output valid when any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select first valid channel index (lowest index has highest priority)
  private val idxWidth = math.max(1, log2Ceil(numChannels))
  val selectedIdx = Wire(UInt(idxWidth.W))
  selectedIdx := 0.U
  when(io.out.valid) {
    selectedIdx := PriorityMux(
      io.in.zipWithIndex.map { case (ch, i) => ch.valid -> i.U(idxWidth.W) }
    )
  }

  // Route selected input data to output
  io.out.bits := 0.U
  when(io.out.valid) {
    io.out.bits := PriorityMux(
      io.in.map(ch => ch.valid -> ch.bits)
    )
  }

  // Only selected input sees ready when output is ready
  for ((ch, i) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && io.out.valid && (selectedIdx === i.U(idxWidth.W))
  }
}
