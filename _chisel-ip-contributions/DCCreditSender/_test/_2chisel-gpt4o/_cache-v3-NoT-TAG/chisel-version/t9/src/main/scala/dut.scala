import chisel3._
import chisel3.util._

/** CreditIO interface for output ports */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

/** dut Module */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))  // Input enqueue interface
    val deq = new CreditIO(data)       // Output dequeue interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Tracks current credits
  })

  // Task 1: Credit Register (icredit) - Stores previous cycle's credit signal
  val icredit = RegNext(io.deq.credit, init = false.B) // Initialize to false.B to avoid undefined behavior

  // Task 2: Credit Counter (curCredit) - Tracks remaining credits
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Initialize to maxCredit
  io.curCredit := curCredit

  // Increment curCredit if icredit is asserted and enq/fire is not happening
  // Decrement curCredit if icredit is not asserted and enq.fire happens
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  } .elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Task 3: Ready Signal (io.enq.ready) - Indicates readiness to accept input
  io.enq.ready := curCredit > 0.U // Ready if there are available credits

  // Task 4: Data Register (dataOut) - Stores data when enq.fire is asserted
  val dataOut = RegEnable(io.enq.bits, io.enq.fire) // Capture io.enq.bits when io.enq.fire is true
  io.deq.bits := dataOut

  // Task 5: Valid Register (validOut) - Valid flag for output data
  val validOut = RegNext(io.enq.fire, init = false.B) // Tracks validity of data
  io.deq.valid := validOut
}
