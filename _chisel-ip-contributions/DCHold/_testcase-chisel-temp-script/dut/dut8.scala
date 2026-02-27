// package decoupled

import chisel3._
import chisel3.util._

/**
 * A ready/valid holding register that holds a data word until it is successfully unloaded.
 * This module ensures there are no combinational paths through it, and can accept data
 * at most every other cycle due to its internal state management.
 *
 * @param data The type of data to be held
 * @tparam D The data type parameter
 */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    // Input interface - receives data to be held
    val enq = Flipped(DecoupledIO(data.cloneType))
    // Output interface - provides held data when consumer is ready
    val deq = DecoupledIO(data.cloneType)
  })

  // State registers
  val pValid = RegInit(false.B)    // Indicates if valid data is currently held
  val pData = Reg(data.cloneType)  // Register to store the held data

  // Default connection - only accept new data when not holding valid data
  io.enq.ready := !pValid

  // Default output - only provide valid data when we have it
  io.deq.valid := pValid
  io.deq.bits := pData

  // State transitions
  when(io.enq.fire) {
    // When new data arrives, store it and mark as valid
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.fire) {
    // When held data is consumed, clear valid flag
    pValid := false.B
  }
}
