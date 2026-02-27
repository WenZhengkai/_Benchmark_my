// package flow

import chisel3._
import chisel3.util._

// CreditIO Bundle definition
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "Maximum credit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Credit counter with the maximum value of maxCredit
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Internal latched credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Data and valid registers for output
  val validOut = RegInit(false.B)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  
  // Credit counter logic:
  // - Increment when credit received and not sending data
  // - Decrement when sending data and not receiving credit
  // - Maintain when both occur or neither occurs
  when(icredit && !io.enq.fire()) {
    creditCounter := creditCounter + 1.U
  }.elsewhen(!icredit && io.enq.fire()) {
    creditCounter := creditCounter - 1.U
  }
  
  // Ensure credit counter doesn't exceed maxCredit
  when(creditCounter > maxCredit.U) {
    creditCounter := maxCredit.U
  }
  
  // Ready to accept data if we have credits available
  io.enq.ready := creditCounter > 0.U
  
  // Valid signal for output
  validOut := Mux(io.enq.fire(), true.B, 
                  Mux(icredit, false.B, validOut))
  
  // Connect output signals
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := creditCounter
}
