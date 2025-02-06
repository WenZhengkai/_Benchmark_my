import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, s"maxCredit must be at least 1, but got $maxCredit")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Implement the Credit Register (icredit)
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Implement the Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when(icredit && !io.deq.valid) {
    curCredit := curCredit + 1.U
  } .elsewhen(io.enq.fire && !icredit) {
    curCredit := curCredit - 1.U
  }

  // Task 3: Implement the Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Task 4: Implement the Data Register (dataOut) & Valid Register (validOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire)

  // Task 5: Integrate the CreditIO Output Logic
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit
}

