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

  // Task 1: Credit Register (icredit)
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Task 3: Drive the Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Task 4: Data Register (dataOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)

  // Task 5: Valid Register (validOut)
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Assign outputs for the CreditIO interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit
}
