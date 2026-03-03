import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be greater than 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output is valid when any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the lowest-index valid channel (highest priority)
  private val selWidth = math.max(1, log2Ceil(numChannels))
  val chosen = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) =>
      ch.valid -> idx.U(selWidth.W)
    }
  )

  // Route selected input data to output
  io.out.bits := io.in(chosen).bits

  // Only selected channel sees ready when output is ready and transfer is valid
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && io.out.valid && (chosen === idx.U(selWidth.W))
  }
}

// Optional Verilog generator
/*
object dut extends App {
  emitVerilog(new dut(numChannels = 4), Array("--target-dir", "generated"))
}
*/
