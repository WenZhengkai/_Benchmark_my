import chisel3._
import chisel3.util._

// Define the CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the dut module
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

  // Output current credit count
  io.curCredit := curCredit

  // Task 3: Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Task 4: Data Register (dataOut)
  val dataOut = RegEnable(io.enq.bits, enable = io.enq.fire)

  // Task 5: Valid Register (validOut)
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Drive the output interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
}
