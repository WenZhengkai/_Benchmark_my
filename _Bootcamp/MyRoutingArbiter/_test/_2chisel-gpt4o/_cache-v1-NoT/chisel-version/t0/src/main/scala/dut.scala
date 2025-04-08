import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Set the `out.valid` to true if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create pairs of index numbers and valid signals.
  val validIndices = io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  // Use PriorityMux to get the index of the first valid input.
  val selectedIdx = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  // Use the selected index to choose which channel's data to output.
  io.out.bits := MuxCase(0.U, io.in.map(ch => ch.valid -> ch.bits))

  // Task 4: Implement Input Readiness Logic
  io.in.zipWithIndex.foreach { case (ch, idx) =>
    ch.ready := (io.out.ready && io.out.valid && (selectedIdx === idx.U))
  }
}
