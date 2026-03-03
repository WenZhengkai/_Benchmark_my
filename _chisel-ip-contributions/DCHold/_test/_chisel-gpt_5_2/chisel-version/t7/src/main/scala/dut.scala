// package dut

import chisel3._
import chisel3.util._

/** Ready/valid holding register (no combinational path from enq to deq).
  * Accepts new data only when empty; holds it until successfully dequeued.
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Holding registers
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Interface defaults
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Handshakes
  val enqFire = io.enq.valid && io.enq.ready
  val deqFire = io.deq.valid && io.deq.ready

  // State transitions
  when(enqFire) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(deqFire) {
    pValid := false.B
  }
}
