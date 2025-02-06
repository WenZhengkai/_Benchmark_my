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
    val enq = Flipped(Decoupled(dataType.cloneType))
    val deq = new CreditIO(dataType.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Implement Credit Register (`icredit`)
  val icredit = RegNext(io.deq.credit, false.B)

  // Task 2: Implement Credit Counter (`curCredit`)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when(io.enq.fire() && !icredit) {
    curCredit := curCredit - 1.U
  }.elsewhen(icredit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  }
  // Ensure curCredit constraints
  assert(curCredit <= maxCredit.U && curCredit >= 0.U, "curCredit out of bounds")

  // Task 3: Define Ready Signal (`io.enq.ready`)
  io.enq.ready := curCredit > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Output the current credit count
  io.curCredit := curCredit
}
