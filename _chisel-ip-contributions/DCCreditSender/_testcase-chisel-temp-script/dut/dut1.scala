// package flow

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
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = new CreditIO(data.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Register to latch the dequeue credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter
  val curCredit = RegInit(UInt(log2Ceil(maxCredit + 1).W), maxCredit.U)
  
  // Credit counter logic
  when(icredit && !io.enq.fire) {
    // Increment credit when receiving credit and not sending data
    curCredit := Mux(curCredit === maxCredit.U, curCredit, curCredit + 1.U)
  }.elsewhen(!icredit && io.enq.fire) {
    // Decrement credit when sending data and not receiving credit
    curCredit := curCredit - 1.U
  }
  
  // Set ready signal when we have credits available
  io.enq.ready := curCredit > 0.U
  
  // Data register for dequeue interface
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  
  // Valid register for dequeue interface
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Connect to output ports
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit
}
