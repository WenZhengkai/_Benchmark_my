import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(numChannels, Flipped(Decoupled(UInt(8.W))))) // Input channels
    val out = Decoupled(UInt(8.W)) // Output channel
  })

  // Task 1: Output Validity Signal Generation
  // Combine all ".valid" signals from the input channels using OR reduction
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Select the index of the valid input channel with the highest priority (lowest index)
  val validIndexes = io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U }
  val selectedChannel = PriorityMux(validIndexes)

  // Task 3: Output Data Routing Implementation
  // Route the `bits` of the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Input Ready Signal Generation
  // Generate `.ready` signals for each input channel
  io.in.zipWithIndex.foreach { case (channel, idx) =>
    channel.ready := (selectedChannel === idx.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // Ensure combinational paths and proper operation across tasks
  // This task is implicitly ensured by how Chisel constructs build the circuits
  // No additional code is necessary for this step at the Chisel level
}

