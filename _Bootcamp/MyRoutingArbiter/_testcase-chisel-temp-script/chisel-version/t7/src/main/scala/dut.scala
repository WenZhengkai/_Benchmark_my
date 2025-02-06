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
  val validIndices = io.in.zipWithIndex.map { case (channel, index) => (channel.valid, index.U) }
  val priorityIndex = PriorityMux(validIndices)

  // Task 3: Implement Data Routing
  io.out.bits := io.in(priorityIndex).bits

  // Task 4: Implement Input Readiness Logic
  io.in.zipWithIndex.foreach { case (channel, index) =>
    channel.ready := io.out.ready && (priorityIndex === index.U)
  }
}

// To test this implementation, you need to create a testbench using ChiselTest or write assertions in a `.fir` file
