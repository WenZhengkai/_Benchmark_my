import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output Validity: Check if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority Selection: Find the first valid input channel
  val validVec = VecInit(io.in.map(_.valid))
  val selectedChannel = PriorityMux(validVec, VecInit((0 until numChannels).map(_.U)))

  // Data Routing: Route data from the selected input channel to output
  io.out.bits := io.in(selectedChannel).bits

  // Input Readiness: Mark the selected input channel as ready if output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U) && io.in(i).valid
  }
}

