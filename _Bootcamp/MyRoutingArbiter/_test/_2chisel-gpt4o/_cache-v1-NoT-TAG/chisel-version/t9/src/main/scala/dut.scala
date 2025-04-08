import chisel3._
import chisel3.util._

/** dut Module
  *
  * A parameterizable arbitration module that selects the highest-priority valid input channel
  * and routes its data to the output channel.
  *
  * @param numChannels Number of input channels
  */
class dut(val numChannels: Int) extends Module {
  // I/O Declaration
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W))                          // Output channel
  })

  // Task 1: Output Validity Signal Generation
  // Combine all input valid signals to determine if the output is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Priority Channel Selection Logic
  // Select the channel with the highest priority using PriorityMux
  val indexWithValid = io.in.zipWithIndex.map { case (in, idx) =>
    (in.valid, idx.U)
  }
  val selectedChannel = PriorityMux(indexWithValid)

  // Task 3: Output Data Routing Implementation
  // Route the data bits from the selected channel to the output
  io.out.bits := Mux1H(
    io.in.zipWithIndex.map { case (in, idx) =>
      (selectedChannel === idx.U) -> in.bits
    }
  )

  // Task 4: Input Ready Signal Generation
  // Generate ready signals for input channels based on the selected channel
  io.in.zipWithIndex.foreach { case (in, idx) =>
    in.ready := (selectedChannel === idx.U) && io.out.ready
  }

  // Task 5: Integration & Verification (Commentary on Signal Timing/Path)
  // - Input valid signals drive the PriorityMux to select the active channel.
  // - The selected channel's data is routed to the output combinationally.
  // - Input ready signals depend on the selected channel and output readiness.
  // - No unintended latches are created as all outputs are driven explicitly.
  // - Properly parameterized for varying numChannels.
}

