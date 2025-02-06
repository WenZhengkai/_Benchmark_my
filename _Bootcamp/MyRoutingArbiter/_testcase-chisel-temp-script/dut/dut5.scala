import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Use reduce with OR to determine if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a list of valid signals and corresponding indices
  val validIndices = io.in.zipWithIndex.map { case (inElem, idx) => (inElem.valid, idx.U) }
  val chosenIdx = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  // Route data from the selected input channel to the output
  io.out.bits := Mux1H(validIndices.map { case (valid, idx) => (valid, io.in(idx.litValue.toInt).bits) })
  
  // Task 4: Implement Input Readiness Logic
  // Set each input channel's `ready` based on the selected channel index and output readiness
  io.in.zipWithIndex.foreach { case (inElem, idx) =>
    inElem.ready := io.out.ready && (chosenIdx === idx.U)
  }
}
