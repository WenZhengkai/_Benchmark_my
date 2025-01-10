

import chisel3._
import chisel3.util._

// Definition of the CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Definition of the DCCreditSender module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val credit = Input(Bool())
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val dataOut = RegEnable(io.enq.bits, io.enq.valid && io.enq.ready)
  val validOut = RegNext(io.enq.valid && io.enq.ready, false.B)

  // Logic for credit counting
  when(io.credit && !icredit) {
    curCredit := curCredit + 1.U
  }

  when(io.enq.fire()) {
    curCredit := curCredit - 1.U
  }

  // Latching the credit signal
  icredit := io.credit

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Output assignments
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit
}


