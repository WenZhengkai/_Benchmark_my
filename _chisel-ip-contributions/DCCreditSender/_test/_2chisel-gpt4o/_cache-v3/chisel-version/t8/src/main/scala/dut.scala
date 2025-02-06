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

  // Credit counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  io.curCredit := curCredit

  // Internal credit register
  val icredit = RegNext(io.deq.credit)

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Dequeue interface logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Credit and debit logic for curCredit
  when(icredit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  } .elsewhen(!icredit && io.enq.fire()) {
    curCredit := curCredit - 1.U
  }
}

