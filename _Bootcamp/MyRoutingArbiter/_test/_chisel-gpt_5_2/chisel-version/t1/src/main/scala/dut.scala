// package dut

import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  require(numChannels > 0, "numChannels must be > 0")

  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Output valid if any input is valid
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Select the lowest-index valid channel (highest priority)
  val sel = PriorityMux(io.in.zipWithIndex.map { case (ch, idx) =>
    (ch.valid, idx.U(log2Ceil(numChannels).W))
  })

  // Route selected data to output
  io.out.bits := io.in(sel).bits

  // Only the selected channel is ready, and only when output is ready
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (sel === i.U)
  }
}

/*
object dut extends App {
  // Example elaboration; adjust numChannels as needed
  emitVerilog(new dut(numChannels = 4), Array("--target-dir", "generated"))
}
*/
