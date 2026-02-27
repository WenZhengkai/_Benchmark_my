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
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal Registers
  val icredit = RegInit(false.B) // Latched credit signal
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W)) // Credit counter
  val dataOut = RegEnable(io.enq.bits, io.enq.fire) // Data register
  val validOut = RegNext(io.enq.fire, false.B) // Valid register

  // Credit Counter Logic
  when(io.deq.credit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!io.deq.credit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Dequeue Interface Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Current Credit Output
  io.curCredit := curCredit

  // Latch the credit signal
  icredit := io.deq.credit
}

// Companion Object for Module Instantiation
object dut {
  def apply[D <: Data](data: D, maxCredit: Int): dut[D] = new dut(data, maxCredit)
}
