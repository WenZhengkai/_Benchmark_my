import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Output Validity Signal Generation
  // Combine validity signals from all input channels
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Find the highest priority (lowest-indexed) valid channel
  val selectedChannel = Wire(UInt(log2Ceil(numChannels).W))
  selectedChannel := PriorityMux(
    io.in.zipWithIndex.map { case (channel, index) => 
      channel.valid -> index.U
    }
  )

  // Task 3: Output Data Routing Implementation
  // Route the data from the selected input channel to the output
  io.out.bits := Mux1H(
    io.in.zipWithIndex.map { case (channel, index) => 
      (selectedChannel === index.U) -> channel.bits
    }
  )

  // Task 4: Input Ready Signal Generation
  // Generate the ready signals for each input channel
  io.in.zipWithIndex.foreach { case (channel, index) =>
    channel.ready := (selectedChannel === index.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // All tasks are already integrated in the flow above.
  // Ensure there are no unintended latches or incorrect paths.
}

