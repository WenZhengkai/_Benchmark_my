// package flow

import chisel3._
import chisel3.util._

// Credit IO Bundle definition
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
  
  // Credit tracking register
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter - starts at maximum credit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Default values
  io.enq.ready := curCredit > 0.U
  
  // Credit counter logic
  when(icredit && !io.enq.fire) {
    // Receiving credit without sending data - increment credit counter
    curCredit := Mux(curCredit === maxCredit.U, curCredit, curCredit + 1.U)
  }.elsewhen(!icredit && io.enq.fire) {
    // Sending data without receiving credit - decrement credit counter
    curCredit := curCredit - 1.U
  }
  
  // Output the current credit value
  io.curCredit := curCredit
  
  // Data register for the output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  
  // Valid register - data is valid when enqueue fires
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Connect output signals
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
