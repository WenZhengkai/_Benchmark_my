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

  // Internal credit register to latch the credit status
  val icredit = RegInit(false.B)
  icredit := io.deq.credit

  // Current credit counter, initialized to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Ready signal for enqueuing data
  io.enq.ready := curCredit > 0.U

  // Data and valid registers for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  // Assign outputs
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit

  // Credit counter updates
  when(io.enq.fire() && !icredit) {
    curCredit := curCredit - 1.U
  }.elsewhen(!io.enq.fire() && icredit && io.deq.credit) {
    curCredit := curCredit + 1.U
  }
}

