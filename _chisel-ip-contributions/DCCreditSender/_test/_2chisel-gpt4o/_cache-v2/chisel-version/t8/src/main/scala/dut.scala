import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1.")
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  io.curCredit := curCredit

  // Ready signal for enqueue interface
  io.enq.ready := curCredit > 0.U

  // Temporary registers for output data and valid signal
  val dataOut = RegEnable(io.enq.bits, enable = io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Manage credits
  when(io.deq.credit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  } .elsewhen(io.enq.fire() && !io.deq.credit) {
    curCredit := curCredit - 1.U
  }

  // Output logic
  io.deq.bits := dataOut
  io.deq.valid := validOut
}

