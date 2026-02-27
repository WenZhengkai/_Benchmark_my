import chisel3._
import chisel3.util._

// Define the CreditIO Bundle
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main dut Module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  // IO Ports
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal Registers
  val icredit = RegInit(false.B) // Credit register
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W)) // Credit counter
  val dataOut = RegEnable(io.enq.bits, io.enq.fire) // Data register
  val validOut = RegNext(io.enq.fire, false.B) // Valid register

  // Credit Logic
  when(io.deq.credit && !io.enq.fire) {
    curCredit := curCredit + 1.U // Increment credit
  }.elsewhen(!io.deq.credit && io.enq.fire) {
    curCredit := curCredit - 1.U // Decrement credit
  }

  // Update icredit register
  icredit := io.deq.credit

  // Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Dequeue Interface Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Output Current Credit
  io.curCredit := curCredit
}

// Companion Object for dut
object dut {
  def apply[D <: Data](data: D, maxCredit: Int): dut[D] = new dut(data, maxCredit)
}
