// package flowcontrol

import chisel3._
import chisel3.util._

// CreditIO bundle definition
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Credit-based flow control sender module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Internal credit register
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter - initially set to maxCredit
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Credit counter update logic
  when (icredit && !io.enq.fire) {
    // Increment credits when credit received and not sending data
    creditCounter := Mux(creditCounter === maxCredit.U, creditCounter, creditCounter + 1.U)
  } .elsewhen (!icredit && io.enq.fire) {
    // Decrement credits when sending data and no credit received
    creditCounter := creditCounter - 1.U
  }
  // No change when both or neither happen
  
  // Output the current credit count
  io.curCredit := creditCounter
  
  // Ready to enqueue when we have credits available
  io.enq.ready := creditCounter > 0.U
  
  // Data and valid registers for the output
  val validOut = RegNext(io.enq.fire, false.B)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  
  // Connect to output ports
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
