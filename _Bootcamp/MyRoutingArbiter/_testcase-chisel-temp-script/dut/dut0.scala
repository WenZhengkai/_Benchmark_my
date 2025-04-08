import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W)) // Output channel
  })

  // Task 1: Output Validity Signal Generation
  // Combine all `valid` signals from the input channels using OR reduction
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Use PriorityMux to select the index of the highest-priority valid channel
  // Create (valid, index) pairs and map to (Bool, UInt) tuples
  val validIndices = io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U }
  val selectedChannel = PriorityMux(validIndices)

  // Task 3: Output Data Routing Implementation
  // Route the .bits of the selected channel to io.out.bits
  io.out.bits := Mux1H(io.in.zipWithIndex.map {
    case (channel, idx) => (selectedChannel === idx.U) -> channel.bits
  })

  // Task 4: Input Ready Signal Generation
  // Generate per-channel ready signals
  io.in.zipWithIndex.foreach { case (channel, idx) =>
    channel.ready := (selectedChannel === idx.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // Ensure correct signal integration and parameterization
  // Already achieved by combining the steps above
}

