// package readyvalidreg

import chisel3._
import chisel3.util._

/**
 * A holding register with ready/valid interfaces
 * Holds a data word until it is successfully unloaded via the deq interface
 * No combinational paths through this module
 * Can accept data at most every other cycle
 *
 * @param data The data type for the payload
 */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // State registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Ready/valid logic
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData

  // Update internal state based on handshake signals
  when(io.enq.valid && io.enq.ready) {
    pValid := true.B
    pData := io.enq.bits
  }.elsewhen(io.deq.valid && io.deq.ready) {
    pValid := false.B
  }
}
