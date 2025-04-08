import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Determine if at least one of the input channels is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a sequence of channel indices
  val validIndices = VecInit(io.in.map(_.valid))
  val priorityChannel = PriorityMux(validIndices, (0 until numChannels).map(_.U))

  // Task 3: Implement Data Routing
  // Route the data from the input channel corresponding to the priority selection
  io.out.bits := io.in(priorityChannel).bits

  // Task 4: Implement Input Readiness Logic
  // Set each input channel's ready signal based on the selected channel and output readiness
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (priorityChannel === i.U)
  }
}

