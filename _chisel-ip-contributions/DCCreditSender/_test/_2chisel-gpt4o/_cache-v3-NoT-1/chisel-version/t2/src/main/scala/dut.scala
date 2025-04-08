import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "The maximum credit must be at least 1.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Implement Credit Register (`icredit`)
  val icredit = RegInit(false.B)
  icredit := io.deq.credit

  // Task 2: Implement Credit Counter (`curCredit`)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  when(io.deq.credit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  } .elsewhen(io.enq.fire && !io.deq.credit) {
    curCredit := curCredit - 1.U
  }

  when(curCredit < 0.U) {
    curCredit := 0.U
  } .elsewhen(curCredit > maxCredit.U) {
    curCredit := maxCredit.U
  }

  io.curCredit := curCredit

  // Task 3: Define Ready Signal (`io.enq.ready`)
  io.enq.ready := curCredit > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
