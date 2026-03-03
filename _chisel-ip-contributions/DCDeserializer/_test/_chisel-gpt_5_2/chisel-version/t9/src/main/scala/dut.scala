// package dut

import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(gen.cloneType)
  })

  // Total bit width of the target parallel type
  val totalBits = gen.getWidth
  require(totalBits > 0, "gen must have a known, non-zero width")

  // Number of serialized beats needed to reconstruct the full word
  val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  val cycleCount = RegInit(0.U(log2Ceil(cycles).max(1).W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  // Handshake policy:
  // - Only accept input when not holding a completed output (dataValid == false)
  // - and when input is valid (or just generally ready to accept)
  io.dataIn.ready := !dataValid

  // Output
  // Note: if totalBits is not an integer multiple of width, the MSB part of the
  // assembled value will include the "extra" bits from the last beat.
  val assembled = dataSelect.asUInt
  io.dataOut.bits  := assembled.asTypeOf(gen)
  io.dataOut.valid := dataValid

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
