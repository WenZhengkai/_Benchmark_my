import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Combine all input 'valid' signals and assign to 'out.valid'
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a list of indices and the corresponding valid signals
  val validIndices = VecInit(io.in.map(_.valid))
  val selectedIndex = PriorityMux(validIndices.zipWithIndex.map { case (v, i) => v -> i.U })

  // Task 3: Implement Data Routing
  // Use the selected index to route the appropriate 'bits' signal to the output
  io.out.bits := MuxLookup(selectedIndex, 0.U, io.in.zipWithIndex.map { case (in, i) =>
    i.U -> in.bits
  })

  // Task 4: Implement Input Readiness Logic
  // Set the 'ready' signal of the selected input channel
  io.in.zipWithIndex.foreach { case (in, i) =>
    in.ready := io.out.ready && (selectedIndex === i.U)
  }
}


