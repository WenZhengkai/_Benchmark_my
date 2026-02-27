// package dut

import chisel3._
import chisel3.util._

// Definition of CreditIO bundle
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

  // Internal credit register to latch the dequeue credit signal
  val icredit = RegNext(io.deq.credit, false.B)
  
  // Credit counter initialized to maxCredit
  val creditCounter = RegInit(UInt(log2Ceil(maxCredit + 1).W), maxCredit.U)
  
  // Credit counter logic
  when(icredit && !io.enq.fire) {
    // Increment credit when receiving credit and not firing enqueue
    creditCounter := Mux(creditCounter === maxCredit.U, creditCounter, creditCounter + 1.U)
  }.elsewhen(!icredit && io.enq.fire) {
    // Decrement credit when firing enqueue and not receiving credit
    creditCounter := creditCounter - 1.U
  }
  
  // Expose current credit count
  io.curCredit := creditCounter
  
  // Enqueue is ready when we have available credits
  io.enq.ready := creditCounter > 0.U
  
  // Register for holding output data, enabled when enqueue fires
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  
  // Register for tracking valid output, set when enqueue fires, reset when not
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Connect output signals
  io.deq.bits := dataOut
  io.deq.valid := validOut
}

// Object for generating Verilog
/*
object dutVerilog extends App {
  // Generate Verilog for a dut with UInt(32.W) data type and 8 max credits
  chisel3.emitVerilog(new dut(UInt(32.W), 8))
}
*/
