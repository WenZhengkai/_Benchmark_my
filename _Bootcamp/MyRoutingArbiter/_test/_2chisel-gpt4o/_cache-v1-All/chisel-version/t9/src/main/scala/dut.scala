import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Determine if at least one of the input channels is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a list of pairs (valid signal, index)
  val validSignals = io.in.zipWithIndex.map { case (inChannel, index) => (inChannel.valid, index.U) }
  // Use PriorityMux to select the index of the first valid channel
  val selectedIndex = PriorityMux(validSignals)

  // Task 3: Implement Data Routing
  // Use Mux to route data from the selected input channel to the output
  io.out.bits := Mux1H(io.in.map(_.valid), io.in.map(_.bits))

  // Task 4: Implement Input Readiness Logic
  // Set each input channel's ready signal based on selected index and output readiness
  io.in.zipWithIndex.foreach { case (inChannel, index) =>
    inChannel.ready := io.out.ready && (selectedIndex === index.U)
  }
}

