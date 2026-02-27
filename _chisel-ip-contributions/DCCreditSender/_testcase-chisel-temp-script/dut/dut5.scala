// package flowcontrol

import chisel3._
import chisel3.util._

// Credit IO Bundle definition
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Credit register to latch the dequeue credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter - tracks available credits
  val creditCounter = RegInit(UInt(log2Ceil(maxCredit + 1).W), maxCredit.U)
  
  // Set ready when there are credits available
  io.enq.ready := creditCounter > 0.U
  
  // Data and valid registers for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)
  
  // Update credit counter:
  // - Increment when credit received and not sending data
  // - Decrement when sending data and no credit received
  // - No change when both or neither happen
  when(icredit && !io.enq.fire()) {
    creditCounter := creditCounter + 1.U
  }.elsewhen(!icredit && io.enq.fire()) {
    creditCounter := creditCounter - 1.U
  }
  
  // Ensure credit counter doesn't exceed maxCredit
  when(creditCounter > maxCredit.U) {
    creditCounter := maxCredit.U
  }
  
  // Connect outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := creditCounter
}
