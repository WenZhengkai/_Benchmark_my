import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W))                          // Output channel
  })

  // Task 1: Output Validity Signal Generation
  io.out.valid := io.in.map(_.valid).reduce(_ || _) // OR reduction of all input valid signals

  // Task 2: Priority Channel Selection Logic
  // Create pairs of (valid, index), and map to PriorityMux
  val selectedChannel = PriorityMux(io.in.zipWithIndex.map { case (in, idx) =>
    (in.valid, idx.U)
  })

  // Task 3: Output Data Routing Implementation
  // Route selected channel's data to the output bits
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Input Ready Signal Generation
  // Generate per-channel ready signals based on selection
  io.in.zipWithIndex.foreach { case (in, idx) =>
    in.ready := (selectedChannel === idx.U) && io.out.ready
  }
}

// Testbench for dut for simulation
