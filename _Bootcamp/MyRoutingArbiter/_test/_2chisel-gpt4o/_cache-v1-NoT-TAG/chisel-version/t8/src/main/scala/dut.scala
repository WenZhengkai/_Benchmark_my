import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W)) // Output channel
  })

  // Task 1: Output Validity Signal Generation
  // Combine valid signals from all input channels
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Create a priority-based selection of the input channel
  val validWithIndex = io.in.zipWithIndex.map { case (channel, index) => (channel.valid, index.U) }
  val selectedChannel = PriorityMux(validWithIndex.map(_._1), validWithIndex.map(_._2))

  // Task 3: Output Data Routing Implementation
  // Route the data from the selected channel to the output
  io.out.bits := Mux1H(
    io.in.zipWithIndex.map { case (channel, index) =>
      (index.U === selectedChannel) -> channel.bits
    }
  )
  
  // Task 4: Input Ready Signal Generation
  // Set the `ready` signal on the input channel that is currently selected
  io.in.zipWithIndex.foreach { case (channel, index) =>
    channel.ready := (selectedChannel === index.U) && io.out.ready
  }

  // Task 5: Integration & Final Wiring
  // No extra logic is required here as the design is modular and flows as specified.

}

