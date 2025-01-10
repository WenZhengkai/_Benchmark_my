import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))  // Input channels
    val out = Decoupled(UInt(8.W))                             // Output channel
  })

  // Helper function to generate selectIdx for PriorityMux
  def channelPriority(): UInt = {
    PriorityMux(io.in.map(_.valid), VecInit(0 until numChannels).map(_.U))
  }

  // Priority Arbitration Logic
  val selectedIdx = channelPriority()                         // Index of the first valid input channel
  val isAnyValid = io.in.map(_.valid).reduce(_ || _)           // OR reduction to check if at least one is valid

  // Data Routing and Output Validity
  io.out.valid := isAnyValid                                  // Output is valid if any input is valid
  io.out.bits := io.in(selectedIdx).bits                      // Pass data from the selected input channel

  // Input Readiness
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedIdx === i.U)   // Ready signal for the selected input channel
  }
}


