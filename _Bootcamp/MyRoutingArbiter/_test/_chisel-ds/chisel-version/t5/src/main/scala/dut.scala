import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection (PriorityMux)
  val selectedChannel = PriorityMux(io.in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) })

  // Data Routing
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}

/*
object dut extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(4), Array("--target-dir", "generated"))
}
*/
