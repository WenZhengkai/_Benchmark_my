// package creditflow

import chisel3._
import chisel3.util._

// Credit IO Bundle definition
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main dut module implementation
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal credit register - latches the dequeue credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter - keeps track of available credits
  val creditCounter = RegInit(UInt(log2Ceil(maxCredit + 1).W), maxCredit.U)
  
  // Logic for updating credit counter
  when (icredit && !io.enq.fire) {
    // Increment credit when receiving credit and not sending data
    creditCounter := Mux(creditCounter === maxCredit.U, creditCounter, creditCounter + 1.U)
  } .elsewhen (!icredit && io.enq.fire) {
    // Decrement credit when sending data and not receiving credit
    creditCounter := creditCounter - 1.U
  }
  
  // Enqueue ready signal - high when there are available credits
  io.enq.ready := creditCounter > 0.U
  
  // Data register - holds the data to be dequeued
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  
  // Valid register - indicates if output data is valid
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Connect outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := creditCounter
}
