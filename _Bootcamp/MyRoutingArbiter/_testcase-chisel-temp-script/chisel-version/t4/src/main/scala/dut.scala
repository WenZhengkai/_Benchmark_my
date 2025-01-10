import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Vec(numChannels, Flipped(Decoupled(UInt(8.W)))) // Input channels
    val out = Decoupled(UInt(8.W))                          // Output channel
  })

  // Step 1: Determine if any input channel is valid
  val validVec = io.in.map(_.valid) // Extract 'valid' signal of all input channels
  io.out.valid := validVec.reduce(_ || _) // Output is valid if any input is valid

  // Step 2: Find the index of the first valid channel using PriorityMux
  val selectedIndex = PriorityMux(validVec.zipWithIndex.map { case (valid, idx) => valid -> idx.U })

  // Step 3: Route the data of the selected input channel to the output
  io.out.bits := Mux1H(validVec, io.in.map(_.bits)) // Only route data from the selected valid input channel

  // Step 4: Set each input channel's ready signal
  io.in.zipWithIndex.foreach { case (inChannel, idx) =>
    inChannel.ready := io.out.ready && (selectedIndex === idx.U)
  }
}


