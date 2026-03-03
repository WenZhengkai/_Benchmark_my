// package dut

import chisel3._
import chisel3.util._

/** Ready/valid holding register with no combinational path through it.
  * Accepts new data only when empty; holds until successfully dequeued.
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Holding registers
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Interface defaults/assignments
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Handshakes
  val doEnq = io.enq.valid && io.enq.ready
  val doDeq = io.deq.valid && io.deq.ready

  when(doEnq) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(doDeq) {
    pValid := false.B
  }
}

/*
object dut extends App {
  // Example elaboration; replace UInt(32.W) with your desired type
  emitVerilog(new dut(UInt(32.W)), Array("--target-dir", "generated"))
}
*/
