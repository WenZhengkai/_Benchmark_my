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

  // Credit register to keep track of dequeue credit signals
  val icredit = RegInit(false.B)

  // Credit counter, initialized to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Registers to hold output data and valid status
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Enqueue readiness logic
  io.enq.ready := (curCredit > 0.U)

  // Data register logic: capture incoming data when enqueue fires and credit available
  when(io.enq.fire()) {
    dataOut := io.enq.bits
  }

  // Validity condition for dequeued data
  validOut := io.enq.fire() || (validOut && !io.deq.credit)

  // Update the output interface
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Credit management logic for icredit and curCredit
  icredit := io.deq.credit
  when(io.deq.credit && !io.enq.fire()) {
    // Increment credit if credit signal is received but no enqueue operation
    curCredit := curCredit + 1.U
  }.elsewhen(!io.deq.credit && io.enq.fire()) {
    // Decrement credit if enqueue operation occurs without crediting
    curCredit := curCredit - 1.U
  }

  // Keep curCredit updated
  io.curCredit := curCredit
}

// To instantiate this module, you need to do something like:
// val creditSender = Module(new DCCreditSender(UInt(8.W), 16))
