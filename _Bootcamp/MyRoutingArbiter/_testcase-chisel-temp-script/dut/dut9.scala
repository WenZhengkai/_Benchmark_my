import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Determine if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a sequence of tuples (valid, index)
  val validIndices = io.in.zipWithIndex.map{ case (in, idx) => (in.valid, idx.U) }
  // PriorityMux to select the index of the first valid channel
  val selectedIdx = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  // Route the data from the selected input channel to the output
  io.out.bits := Mux1H(validIndices.map{ case (v, idx) => (v, io.in(idx).bits) })

  // Task 4: Implement Input Readiness Logic
  // Set each input channel's ready signal based on the selected channel index and output readiness
  io.in.zipWithIndex.foreach { case (in, idx) =>
    in.ready := io.out.ready && (selectedIdx === idx.U)
  }
}

