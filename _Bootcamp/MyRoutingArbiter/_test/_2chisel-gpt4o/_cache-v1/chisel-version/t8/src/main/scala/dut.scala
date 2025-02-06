package arbiter
import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Determine if any input channel is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // PriorityMux to select the first valid input channel index
  val priorityIdx = PriorityMux(io.in.map(_.valid), (0 until numChannels).map(_.U))

  // Route data from the selected input channel to the output
  io.out.bits := MuxLookup(priorityIdx, 0.U, io.in.zipWithIndex.map { case (in, idx) =>
    idx.U -> in.bits
  })

  // Determine readiness of input channels
  io.in.zipWithIndex.foreach { case (in, idx) =>
    in.ready := io.out.ready && (priorityIdx === idx.U)
  }
}

