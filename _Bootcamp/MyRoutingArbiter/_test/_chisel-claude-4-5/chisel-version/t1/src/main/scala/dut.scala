import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: Check if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Select the channel number of the first valid input channel
  val selectedChannel = PriorityMux(
    io.in.zipWithIndex.map { case (channel, idx) => 
      channel.valid -> idx.U
    }
  )

  // Data Routing: Route the data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Mark the selected channel as ready if output is ready
  for (idx <- 0 until numChannels) {
    io.in(idx).ready := io.out.ready && (selectedChannel === idx.U) && io.in(idx).valid
  }
}

// Optional: Object for generating Verilog
/*
object dut extends App {
  println("Generating Verilog for dut module...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(numChannels = 4),
    Array("--target-dir", "generated")
  )
}
*/
