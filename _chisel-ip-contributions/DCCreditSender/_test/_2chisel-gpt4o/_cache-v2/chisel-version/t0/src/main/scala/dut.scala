import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register
  val icredit = RegInit(false.B)

  // Credit counter initialized to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Output data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Connect IO
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := curCredit

  // Logic: Handle credit and ready signal
  when(io.deq.credit && !validOut) {
    // Increase credit count when credit is received and no data is being sent
    curCredit := curCredit + 1.U
  }

  when(io.enq.fire()) {
    // Decrease credit count when data is sent (if there is credit)
    curCredit := curCredit - 1.U
  }

  // Determine enqueue readiness based on available credit
  io.enq.ready := curCredit > 0.U

  // Handle internal credit logic
  icredit := io.deq.credit
}
