import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val credit = Input(Bool())
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register
  val icredit = RegInit(false.B)

  // Current credit counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  io.curCredit := curCredit

  // Ready signal for enqueuing data
  io.enq.ready := curCredit > 0.U

  // Temporary registers for holding output data and valid flag
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Dequeue output logic
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Credit logic
  when(io.credit && !io.deq.valid) {
    curCredit := curCredit + 1.U
  }

  when(io.enq.fire() && !io.credit) {
    curCredit := curCredit - 1.U
  }

  // Capture the incoming credit to icredit for later decision making
  icredit := io.credit

  // Ensure deq.valid is cleared when output data is acknowledged and credit is not received
  when(io.deq.valid && !io.deq.credit) {
    validOut := false.B
  }
}

// Define the CreditIO as specified
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}
