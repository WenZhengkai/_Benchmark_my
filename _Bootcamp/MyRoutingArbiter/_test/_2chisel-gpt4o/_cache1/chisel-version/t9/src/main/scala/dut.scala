import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Default output settings
  io.out.valid := false.B
  io.out.bits := 0.U

  // PriorityMux implementation to choose the first valid channel
  val validIndexes = VecInit((0 until numChannels).map(i => io.in(i).valid))
  val selectedChannel = PriorityMux(validIndexes, (0 until numChannels).map(_.U))

  // Set the output signals based on the selected channel
  when(validIndexes.reduce(_ || _)) {
    io.out.valid := true.B
    io.out.bits := io.in(selectedChannel).bits
  }

  // Set the input readiness for each channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selectedChannel === i.U)
  }
}


