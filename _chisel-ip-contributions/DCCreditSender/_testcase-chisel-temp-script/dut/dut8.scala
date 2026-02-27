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
  
  // Credit register - latches the dequeue credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter - keeps track of currently available credits
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Default value for enq.ready
  io.enq.ready := creditCounter > 0.U
  
  // Data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)
  
  // Connect to output
  io.deq.bits := dataOut
  io.deq.valid := validOut
  
  // Update credit counter
  when(icredit && !io.enq.fire()) {
    // Received credit but not sending data - increment credit counter
    creditCounter := Mux(creditCounter === maxCredit.U, 
                         maxCredit.U, 
                         creditCounter + 1.U)
  }.elsewhen(!icredit && io.enq.fire()) {
    // Not receiving credit but sending data - decrement credit counter
    creditCounter := creditCounter - 1.U
  }
  // When both happen or neither happens, credit counter stays the same
  
  // Output the current credit value
  io.curCredit := creditCounter
}
