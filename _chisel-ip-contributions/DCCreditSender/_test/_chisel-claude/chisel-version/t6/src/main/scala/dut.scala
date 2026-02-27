// package flowcontrol

import chisel3._
import chisel3.util._

// Credit-based IO bundle definition
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
  
  // Register to track current available credits
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Default values
  io.deq.valid := false.B
  io.deq.bits := DontCare
  io.enq.ready := false.B
  
  // Credit counter logic
  when(icredit && !io.enq.fire) {
    // Increment credit when receiving credit and not firing enqueue
    curCredit := Mux(curCredit === maxCredit.U, curCredit, curCredit + 1.U)
  }.elsewhen(!icredit && io.enq.fire) {
    // Decrement credit when not receiving credit and firing enqueue
    curCredit := curCredit - 1.U
  }
  
  // Ready to accept data when we have credits
  io.enq.ready := curCredit > 0.U
  
  // Data and valid register for dequeue interface
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Connect registers to output
  io.deq.valid := validOut
  io.deq.bits := dataOut
  
  // Output current credit
  io.curCredit := curCredit
}
