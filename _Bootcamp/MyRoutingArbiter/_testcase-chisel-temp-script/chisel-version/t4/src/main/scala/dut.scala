import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W)) // Output channel
  })

  // Task 1: Output Validity Signal Generation
  // Create the OR-aggregation of all input `valid` signals
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Select the lowest-indexed valid channel using PriorityMux
  val validAndIndex = io.in.zipWithIndex.map { case (channel, idx) =>
    (channel.valid, idx.U)
  }
  val selectedChannel = PriorityMux(validAndIndex, validAndIndex.map(_._2))

  // Task 3: Output Data Routing Implementation
  // Direct the selected channel's data to the output
  io.out.bits := Mux1H(io.in.zipWithIndex.map { case (channel, idx) =>
    (selectedChannel === idx.U) -> channel.bits
  })

  // Task 4: Input Ready Signal Generation
  // Generate `ready` signals for all input channels
  io.in.zipWithIndex.foreach { case (channel, idx) =>
    // The channel is ready if it is the selected channel and the output is ready
    channel.ready := (selectedChannel === idx.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // All signals are integrated and parameterized to handle `numChannels`
  // No unintended latches are created because the logic is purely combinational
}

