// package dut

import chisel3._
import chisel3.util._

/**
  * Deserializer: collects a serialized stream (width bits/cycle) into a parallel word of type D.
  *
  * - Accepts `cycles = ceil(data.getWidth / width)` beats on `dataIn`.
  * - Only asserts/acknowledges completion by raising `dataOut.valid` once the full word is captured.
  * - Does not accept new input while holding a completed word waiting for `dataOut.ready`.
  */
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")
  require(data.getWidth > 0, "data.getWidth must be > 0")

  private val totalBits = data.getWidth
  private val cycles    = (totalBits + width - 1) / width
  private val cntW      = if (cycles <= 1) 1 else log2Ceil(cycles)

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(cntW.W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Ready to accept input only when we are not holding a completed output word.
  // (Optionally allow immediate restart if output is being accepted in same cycle.)
  io.dataIn.ready := !dataValid || io.dataOut.fire

  // Capture incoming beats
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output assembly: concatenate beats and truncate to the exact payload width, then cast to D
  val assembled = Cat(dataSelect.reverse).asUInt
  val truncated = assembled(totalBits - 1, 0)
  io.dataOut.bits  := truncated.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Once consumer accepts output, clear valid (ready for next word)
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
