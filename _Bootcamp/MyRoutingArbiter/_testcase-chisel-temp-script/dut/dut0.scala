import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Step 1: Determine `out.valid`
  // `out.valid` is true if any of the input channels are valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Step 2: Use a PriorityMux to select the first valid input channel
  // PriorityMux is used to select the data (`bits`) from the first valid channel.
  io.out.bits := PriorityMux(io.in.map(_.valid), io.in.map(_.bits))

  // Step 3: Determine `ready` signal for each input channel
  // Only the selected channel is marked `ready`, which happens when `io.out.ready` is true.
  for ((inChannel, index) <- io.in.zipWithIndex) {
    inChannel.ready := io.out.ready && (PriorityMux(io.in.map(_.valid), (0 until numChannels).map(_.U)) === index.U)
  }
}

