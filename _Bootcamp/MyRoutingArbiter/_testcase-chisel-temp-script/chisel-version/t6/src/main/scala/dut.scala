import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Objective: Set the out.valid signal to true if at least one of the input channels is valid.
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Objective: Select the channel index of the first valid input channel using a PriorityMux.
  val valid_indices = io.in.zipWithIndex.map { case (channel, index) => index.U -> channel.valid }
  val selectedIdx = PriorityMux(valid_indices)

  // Task 3: Implement Data Routing
  // Objective: Route the data from the selected input channel to the output.
  io.out.bits := Mux1H(io.in.map(_.valid), io.in.map(_.bits))

  // Task 4: Implement Input Readiness Logic
  // Objective: Set each input channel's ready signal based on the selected channel index and output readiness.
  for ((channel, idx) <- io.in.zipWithIndex) {
    channel.ready := io.out.ready && (selectedIdx === idx.U)
  }
}

