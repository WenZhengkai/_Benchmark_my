import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Output Validity Signal Generation
  // Combine all input valid signals into one validity signal for output
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Determine which input channel gets access using PriorityMux
  // Zip validity with index, map to a tuple of (valid, index.U), then use PriorityMux
  val validWithIndex = io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U }
  val selectedChannel = PriorityMux(validWithIndex, io.in.indices.map(_.U))

  // Task 3: Output Data Routing Implementation
  // Route the selected channel's data to the output
  io.out.bits := Mux1H(io.in.zipWithIndex.map { case (ch, idx) =>
    (selectedChannel === idx.U) -> ch.bits
  })

  // Task 4: Input Ready Signal Generation
  // Generate per-channel ready signals based on selection
  io.in.zipWithIndex.foreach { case (ch, idx) =>
    ch.ready := (selectedChannel === idx.U) && io.out.ready
  }
}

