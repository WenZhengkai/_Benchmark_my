package MyRoutingArbiter
import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Flipped(Vec(numChannels, Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Default output is invalid
  io.out.valid := false.B
  io.out.bits  := 0.U

  // Find the first valid input channel
  val valids = io.in.map(_.valid)
  val priorityEncoder = PriorityEncoder(valids)

  // Set the output validity based on any valid input channel
  io.out.valid := valids.reduce(_ || _)

  // Use PriorityMux to get the data from the selected channel and set the output bits
  io.out.bits := PriorityMux(valids, io.in.map(_.bits))

  // Set ready signal for each input channel
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (priorityEncoder === i.U)
  }
}

// Testbench or Main application to use the MyRoutingArbiter module
// You can create a Chisel testbench to instantiate and test `MyRoutingArbiter`
// using ChiselTest or similar testing frameworks.


