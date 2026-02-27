// package flow

import chisel3._
import chisel3.util._

// CreditIO bundle definition
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main dut module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Credit counter logic
  val creditCount = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Latch the credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Data register for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  
  // Valid register for output
  val validOut = RegInit(false.B)
  when(io.enq.fire()) {
    validOut := true.B
  }.elsewhen(icredit) {
    validOut := false.B
  }
  
  // Credit counter update logic
  val creditIncr = icredit && !validOut
  val creditDecr = io.enq.fire()
  
  when(creditIncr && !creditDecr) {
    creditCount := creditCount + 1.U
  }.elsewhen(!creditIncr && creditDecr) {
    creditCount := creditCount - 1.U
  }
  
  // Connect the enq.ready signal based on available credits
  io.enq.ready := creditCount > 0.U
  
  // Connect the output signals
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := creditCount
}
