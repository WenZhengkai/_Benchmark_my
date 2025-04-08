import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W)) // Output channel
  })

  // Task 1: Output Validity Signal Generation
  val validSignals = io.in.map(_.valid) // Extract validity signals from input channels
  io.out.valid := validSignals.reduce(_ || _) // OR-aggregation for output validity

  // Task 2: Priority Channel Selection Logic
  // Create pairs of (valid, index) and map them for PriorityMux
  val validIndices = io.in.zipWithIndex.map { case (input, index) => input.valid -> index.U }
  val selectedChannel = PriorityMux(validIndices) // Select index of the highest priority valid input

  // Task 3: Output Data Routing Implementation
  // Use the selectedChannel index to route the corresponding input data
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Input Ready Signal Generation
  // Generate per-channel ready signals based on selected channel
  io.in.zipWithIndex.foreach { case (input, index) =>
    input.ready := (selectedChannel === index.U) && io.out.ready // Only the selected channel has its ready signal asserted
  }
}

