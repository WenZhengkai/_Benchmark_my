import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W))                           // Output channel
  })

  // Initialize `out.valid` as false, `out.bits` as zero by default
  io.out.valid := false.B
  io.out.bits  := 0.U

  // Default all input channels' `ready` signals to false
  for (i <- 0 until numChannels) {
    io.in(i).ready := false.B
  }

  // Check for at least one valid input and create a priority encoder for valid channels
  val validVec = VecInit(io.in.map(_.valid)) // Collect all `valid` signals into a vector
  val selectedChannel = PriorityMux(validVec, VecInit((0 until numChannels).map(_.U))) // Find the first valid channel
  val hasValidInput = validVec.asUInt.orR // True if at least one input channel is valid

  // Set the output valid and bits only when there is a valid input
  io.out.valid := hasValidInput
  when(hasValidInput) {
    io.out.bits := io.in(selectedChannel).bits // Route data from selected input channel
  }

  // Set the `ready` signal for the selected channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}

