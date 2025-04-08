import chisel3._
import chisel3.util._

// CreditIO: Custom interface for credit-based flow control.
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// dut Module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))  // Input interface for enqueueing data
    val deq = new CreditIO(data)       // Output interface for dequeueing data
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credit count
  })

  // Task 1: Credit Register (icredit)
  val icredit = RegNext(io.deq.credit, false.B)

  // Task 2: Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U // Increment credit when credit is high and enqueue is not firing
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U // Decrement credit when credit is low and enqueue is firing
  }

  // Output current credit through the interface
  io.curCredit := curCredit

  // Task 3: Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U // Ready signal is true only when credits are available

  // Task 4: Data Register (dataOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)

  // Task 5: Valid Register (validOut)
  val validOut = RegNext(io.enq.fire, false.B) // Track if output data is valid

  // Drive outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
