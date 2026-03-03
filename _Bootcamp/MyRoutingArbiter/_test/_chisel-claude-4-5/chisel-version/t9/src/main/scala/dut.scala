import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: Set to true if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Select the channel number of the first valid input channel
  val selectedChannel = PriorityMux(
    io.in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) }
  )

  // Data Routing: Route the data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Mark the selected input channel as ready if output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U) && io.in(i).valid
  }
}

// Optional: Object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(numChannels = 4),
    Array("--target-dir", "generated")
  )
}
*/
