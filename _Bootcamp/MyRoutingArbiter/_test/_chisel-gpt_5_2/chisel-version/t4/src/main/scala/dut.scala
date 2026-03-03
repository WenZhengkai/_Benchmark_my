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

  // Priority select the first valid channel (lowest index wins)
  val selIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  )

  // Route selected data to output
  io.out.bits := io.in(selIdx).bits

  // Only the selected channel gets ready when output is ready
  for ((ch, idx) <- io.in.zipWithIndex) {
    ch.ready := io.out.ready && ch.valid && (selIdx === idx.U)
  }
}

/*
object dut extends App {
  // Example elaboration:
  // sbt "runMain dut --target-dir generated --numChannels 4"
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(numChannels = 4))
}
*/
