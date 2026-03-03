// package dut

import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output valid if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Priority select the lowest-indexed valid channel
  val selIdx = PriorityMux(
    io.in.zipWithIndex.map { case (ch, idx) => (ch.valid, idx.U) }
  )

  // Route selected channel data to output
  io.out.bits := io.in(selIdx).bits

  // Only selected channel is ready, and only when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (selIdx === i.U)
  }
}
