import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Determine the validity of the output by checking if at least one input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Use PriorityMux to select the first valid channel based on priority
  val validInputIndices = io.in.zipWithIndex.map { case (input, idx) => 
    (input.valid, idx.U)
  }
  val selectedChannel = PriorityMux(validInputIndices)

  // Route the data from the selected channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Set readiness for each input channel
  for ((input, idx) <- io.in.zipWithIndex) {
    input.ready := io.out.ready && (selectedChannel === idx.U)
  }
}
