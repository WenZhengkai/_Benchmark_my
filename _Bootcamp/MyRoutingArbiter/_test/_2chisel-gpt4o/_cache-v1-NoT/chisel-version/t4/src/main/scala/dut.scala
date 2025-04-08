import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Compute if at least one channel is valid
  val anyValid = io.in.map(_.valid).reduce(_ || _)
  io.out.valid := anyValid

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a vector of priority candidates
  val priorityList = io.in.zipWithIndex.map { case (channel, idx) =>
    (channel.valid, idx.U)
  }
  // Use a PriorityMux to determine the first valid channel index
  val selectedChannelIndex = PriorityMux(priorityList)

  // Task 3: Implement Data Routing
  // Route data from the selected input channel to the output
  io.out.bits := Mux1H(io.in.zipWithIndex.map { case (channel, idx) =>
    (selectedChannelIndex === idx.U, channel.bits)
  })

  // Task 4: Implement Input Readiness Logic
  // Set readiness for each channel
  io.in.zipWithIndex.foreach { case (channel, idx) =>
    channel.ready := io.out.ready && (selectedChannelIndex === idx.U)
  }
}


