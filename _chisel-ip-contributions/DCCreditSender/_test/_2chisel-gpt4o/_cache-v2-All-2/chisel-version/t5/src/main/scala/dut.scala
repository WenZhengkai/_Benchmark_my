import chisel3._
import chisel3.util._

// Definition of CreditIO data bundle
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Definition of the DCCreditSender module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Enqueue interface
    val deq = new CreditIO(data)       // Dequeue Interface
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Implement the Credit Register (icredit)
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Implement the Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Increment credit when a credit is received and no data is dequeued
  when(io.deq.credit && !io.deq.valid) {
    curCredit := curCredit + 1.U
  }
  
  // Decrement credit when data is dequeued
  when(io.deq.valid && !io.deq.credit) {
    curCredit := curCredit - 1.U
  }

  io.curCredit := curCredit

  // Task 3: Implement the Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Task 4: Implement the Data Register (dataOut) & Valid Register (validOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.valid && io.enq.ready)
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Task 5: Integrate the CreditIO Output Logic
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Manage input condition for the credit
  when(io.deq.valid && io.deq.credit) {
    // Logic can be adjusted based on how the credit input affects dequeue logic
  }
}

