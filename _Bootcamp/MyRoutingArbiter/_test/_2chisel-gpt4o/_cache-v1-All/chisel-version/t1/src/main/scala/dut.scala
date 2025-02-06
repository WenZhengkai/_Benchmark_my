import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  // Check if at least one input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  // Create a sequence of tuples with channel index and valid signal
  val validWithIndex = io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }

  // PriorityMux to select the index of the first valid channel
  val selectedIndex = PriorityMux(validWithIndex.unzip)

  // Task 3: Implement Data Routing
  // Route data from the selected input to output
  io.out.bits := Mux1H(
    io.in.map(_.valid),
    io.in.map(_.bits)
  )

  // Task 4: Implement Input Readiness Logic
  // Set readiness on the input channel that is selected by the PriorityMux
  for ((inChannel, idx) <- io.in.zipWithIndex) {
    inChannel.ready := io.out.ready && (selectedIndex === idx.U)
  }
}

