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

  // Task 1: Implement Credit Register (`icredit`)
  val icredit = RegNext(io.deq.credit)

  // Task 2: Implement Credit Counter (`curCredit`)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  when (icredit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  }.elsewhen (io.enq.fire() && !icredit) {
    curCredit := curCredit - 1.U
  }

  // Ensure curCredit does not exceed limits
  when (curCredit > maxCredit.U) {
    curCredit := maxCredit.U
  }.elsewhen (curCredit < 0.U) {
    curCredit := 0.U
  }

  io.curCredit := curCredit

  // Task 3: Define Ready Signal (`io.enq.ready`)
  io.enq.ready := curCredit > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  // `io.deq.credit` input already connected in credit handling
}

