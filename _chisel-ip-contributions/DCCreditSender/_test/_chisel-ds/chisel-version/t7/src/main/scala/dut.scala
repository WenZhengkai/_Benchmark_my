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

  // Internal Credit Register
  val icredit = RegInit(false.B)

  // Credit Counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  // Data and Valid Registers
  val dataOut = RegEnable(io.enq.bits, 0.U.asTypeOf(data), io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Credit Logic
  when(io.deq.credit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!io.deq.credit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Output Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := curCredit

  // Update icredit
  icredit := io.deq.credit
}

// Companion Object for easier instantiation
object dut {
  def apply[D <: Data](data: D, maxCredit: Int): dut[D] = new dut(data, maxCredit)
}
