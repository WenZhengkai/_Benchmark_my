import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(numChannels, Flipped(Decoupled(UInt(8.W)))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Determine if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create pairs (validSignal, index) for PriorityMux
  val validIndices = io.in.zipWithIndex.map { case (ch, idx) =>
    (ch.valid, idx.U)
  }
  val selectedChannel = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  // Route the data from the selected input channel to the output
  io.out.bits := io.in(selectedChannel).bits

  // Task 4: Implement Input Readiness Logic
  // Set input channel `ready` signal
  io.in.zipWithIndex.foreach { case (ch, idx) =>
    ch.ready := io.out.ready && (selectedChannel === idx.U)
  }
}

