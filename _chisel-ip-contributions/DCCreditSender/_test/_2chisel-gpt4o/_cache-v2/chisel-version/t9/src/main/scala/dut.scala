import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal Registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(io.curCredit.getWidth.W))

  // Assign the current credit to output interface
  io.curCredit := curCredit

  // Data and Valid Registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  // Dequeue Interface Assignments
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Ready Signal Logic
  io.enq.ready := (curCredit > 0.U)

  // Credit Mechanism Logic
  when (io.deq.credit) {
    icredit := true.B
  }.otherwise {
    icredit := false.B
  }

  when(io.enq.fire() && icredit) {
    // Data sent and credit received
    curCredit := curCredit
  }.elsewhen(io.enq.fire()) {
    // Data sent, no credit received
    curCredit := curCredit - 1.U
  }.elsewhen(icredit) {
    // No data sent, credit received
    curCredit := curCredit + 1.U
  }

  // Protecting from over incrementing or decrementing credit
  when(curCredit === maxCredit.U && icredit) {
    curCredit := curCredit
  }.elsewhen(curCredit === 0.U && io.enq.fire()) {
    curCredit := curCredit
  }
}


