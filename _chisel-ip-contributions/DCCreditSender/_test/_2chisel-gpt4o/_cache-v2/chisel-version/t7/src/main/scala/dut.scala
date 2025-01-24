import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal Registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Update icredit based on io.deq.credit signal
  icredit := io.deq.credit

  // Logic for maintaining and updating current credits
  when(io.enq.fire() && !icredit) {
    curCredit := curCredit - 1.U
  } .elsewhen(!io.enq.fire() && icredit) {
    curCredit := curCredit + 1.U
  }

  // Ready signal for enq interface: High when curCredit > 0
  io.enq.ready := curCredit > 0.U

  // Data and Valid registers for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Connect output signals
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Output current credit count
  io.curCredit := curCredit
}

