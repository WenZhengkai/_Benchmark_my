import chisel3._
import chisel3.util._

// Custom CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// DCCreditSender Module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Implement the Credit Register (icredit)
  val creditReg = RegNext(io.deq.credit, init = false.B)

  // Task 2: Implement the Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when(io.deq.credit && !io.deq.valid) {
    // Increment curCredit when credit is granted and data not dequeued
    curCredit := curCredit + 1.U
  }.elsewhen(io.deq.valid && !io.deq.credit) {
    // Decrement curCredit when data dequeued without new credit
    when(curCredit > 0.U) {
      curCredit := curCredit - 1.U
    }
  }

  io.curCredit := curCredit

  // Task 3: Implement the Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Task 4: Implement the Data Register (dataOut) & Valid Register (validOut)
  val dataOut = RegEnable(io.enq.bits, 0.U.asTypeOf(data), io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Task 5: Integrate the CreditIO Output Logic
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Manage the input condition for credit
  when(io.deq.valid && io.deq.credit) {
    curCredit := curCredit + 1.U
  }

  // Ensure proper credit accounted when data is being transferred successfully
  when(io.enq.fire() && curCredit =/= 0.U) {
    curCredit := curCredit - 1.U
  }
}

