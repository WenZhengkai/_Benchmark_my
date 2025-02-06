import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = new CreditIO(data.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Implement the Credit Register (icredit)
  val icredit = Reg(Bool())
  icredit := RegNext(io.deq.credit, false.B)

  // Task 2: Implement the Credit Counter (curCredit)
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when (io.deq.credit && !io.enq.fire) { // credit is granted
    creditCounter := creditCounter + 1.U
  }.elsewhen (io.enq.fire && !io.deq.credit) { // data is dequeued without a new credit
    creditCounter := creditCounter - 1.U
  }

  io.curCredit := creditCounter

  // Task 3: Implement the Ready Signal (io.enq.ready)
  io.enq.ready := creditCounter > 0.U

  // Task 4: Implement the Data and Valid Registers
  val dataOut = RegEnable(io.enq.bits, 0.U.asTypeOf(data.cloneType), io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Task 5: Integrate the CreditIO Output Logic
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Ensure valid status is maintained correctly
  when (!validOut && io.deq.credit) {
    validOut := false.B
  }

  // Summary: This module uses credit-based flow control to manage data traffic.
}

