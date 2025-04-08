import chisel3._
import chisel3.util._

// Define the CreditIO Bundle
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)

  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be >= 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Credit Register (icredit)
  // Register to latch the credit signal from io.deq.credit
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Connect curCredit to the output
  io.curCredit := curCredit

  // Task 3: Ready Signal (io.enq.ready)
  // io.enq.ready is driven by whether there are available credits
  io.enq.ready := curCredit > 0.U

  // Task 4: Data Register (dataOut)
  // Register to store data when enq.fire is asserted
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)

  // Task 5: Valid Register (validOut)
  // Register to track the validity of the output data
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Connect outputs from the module to io.deq
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
