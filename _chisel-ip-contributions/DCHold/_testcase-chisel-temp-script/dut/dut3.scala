// package dut

import chisel3._
import chisel3.util._

/** A ready/valid holding register that holds a data word until it is unloaded.
  * 
  * This module provides a synchronous holding mechanism between input and output
  * interfaces using ready and valid signaling, with no combinational paths through
  * it. Due to its internal state management, it can accept data at most every
  * other cycle.
  * 
  * @param data The data type for the payload
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    // Input interface
    val enq = Flipped(DecoupledIO(data.cloneType))
    // Output interface
    val deq = DecoupledIO(data.cloneType)
  })

  // State registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Default values
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData

  // When data is being enqueued and we're ready to accept it
  when(io.enq.valid && io.enq.ready) {
    pData := io.enq.bits
    pValid := true.B
  }

  // When data is being dequeued
  when(io.deq.valid && io.deq.ready) {
    pValid := false.B
  }
}

// Companion object for factory methods
object dut {
  def apply[D <: Data](data: D): dut[D] = new dut(data)
}
