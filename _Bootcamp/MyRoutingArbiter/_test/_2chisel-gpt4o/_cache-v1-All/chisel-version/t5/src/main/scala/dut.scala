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
  // Generate a list of valid signals to be used by PriorityMux
  val validBits = VecInit(io.in.map(_.valid))
  // PriorityMux selects the first index (lowest) with a valid input
  val selectedIndex = PriorityMux(validBits, (0 until numChannels).map(_.U))

  // Task 3: Implement Data Routing
  // Using the selected index, route the corresponding input data to output
  io.out.bits := Mux1H(validBits, io.in.map(_.bits))

  // Task 4: Implement Input Readiness Logic
  // Set input channel's ready signal based on selected index and output readiness
  for (i <- 0 until numChannels) {
    // Only the selected channel will have its ready set to true
    io.in(i).ready := io.out.ready && (selectedIndex === i.U)
  }
}


