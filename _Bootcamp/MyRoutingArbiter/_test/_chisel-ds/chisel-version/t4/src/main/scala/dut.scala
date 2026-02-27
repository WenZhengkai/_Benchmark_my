import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output validity: out.valid is true if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority selection: Find the index of the first valid input channel
  val selectedChannel = PriorityMux(io.in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) })

  // Data routing: Route the bits of the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input readiness: Only the selected channel is ready if the output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(4), Array("--target-dir", "generated"))
}
*/
