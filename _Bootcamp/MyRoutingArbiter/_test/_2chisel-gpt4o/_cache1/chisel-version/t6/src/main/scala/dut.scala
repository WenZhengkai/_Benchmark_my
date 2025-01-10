import chisel3._
import chisel3.util._

/**
 * MyRoutingArbiter
 * 
 * A hardware arbitration module that routes data from multiple input channels to a single output channel.
 * Priority is given to the lowest-indexed valid input channel.
 * 
 * @param numChannels Number of input channels.
 */
class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "Number of channels must be greater than 0")

  val io = IO(new Bundle {
    val in = Input(Vec(numChannels, Flipped(Decoupled(UInt(8.W))))) // Input channels
    val out = Decoupled(UInt(8.W))                                 // Output channel
  })

  // Determine if any input channel is valid
  val validVec = io.in.map(_.valid)             // Array of valid signals from input channels
  io.out.valid := validVec.reduce(_ || _)       // Output is valid if at least one input is valid

  // PriorityMux to select the first valid input channel
  val firstValidIndex = PriorityMux(validVec, (0 until numChannels).map(_.U)) // Index of the first valid channel

  // Route data from the selected input channel to the output
  io.out.bits := Mux1H(validVec, io.in.map(_.bits)) // Data from the first valid channel

  // Generate ready signals for each input channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (firstValidIndex === i.U) // Ready if the output is ready and this channel is selected
  }
}


