// Import the Chisel package
import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  val validIndices = io.in.zipWithIndex.map { case (chan, index) => index.U -> chan.valid }
  val selectedIndex = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  io.out.bits := io.in(selectedIndex).bits

  // Task 4: Implement Input Readiness Logic
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedIndex === i.U)
  }
}

