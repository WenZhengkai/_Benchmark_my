import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Output Validity Signal Generation
  // Combine all input valid signals to drive io.out.valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Create a PriorityMux to select the channel index with the highest priority (lowest index)
  val validWithIndex = io.in.zipWithIndex.map { case (channel, index) =>
    (channel.valid, index.U)
  }
  val selectedChannel = PriorityMux(validWithIndex)

  // Task 3: Output Data Routing Implementation
  // Route the data from the selected channel to io.out.bits
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Input Ready Signal Generation
  // Generate ready signals for each input channel
  io.in.zipWithIndex.foreach { case (channel, index) =>
    channel.ready := (selectedChannel === index.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // Ensure that all combinational logic paths and timing constraints are valid
  // The above implementation inherently handles integration as it directly connects valid, bits, and ready signals
}
