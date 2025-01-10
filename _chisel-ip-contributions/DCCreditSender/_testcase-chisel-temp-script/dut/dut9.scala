import chisel3._
import chisel3.util._

/**
 * A custom CreditIO Bundle for credit-based flow control.
 * @param data The data type for the payload being sent/received.
 */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid  = Output(Bool())
  val credit = Input(Bool())
  val bits   = Output(data.cloneType)

  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

/**
 * DCCreditSender Module implementing a credit-based flow control sender.
 * @param data The type of data enqueued/dequeued.
 * @param maxCredit The maximum number of credits allowed for the sender.
 */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  
  val io = IO(new Bundle {
    val enq       = Flipped(Decoupled(data)) // Enqueue input interface
    val credit    = Input(Bool())           // Credit input signal
    val deq       = new CreditIO(data)      // Dequeue output interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credit count
  })

  // Registers and internal variables
  val icredit       = RegInit(false.B)                     // Latched credit signal
  val curCredit     = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Credit counter
  val dataOut       = RegEnable(io.enq.bits, io.enq.fire())       // Holds data for dequeue
  val validOut      = RegNext(io.enq.fire(), false.B)             // Valid signal generator

  // Connecting current credit count to output
  io.curCredit := curCredit

  // Enqueue Ready Logic
  io.enq.ready := (curCredit > 0.U)

  // Dequeue Logic
  io.deq.valid := validOut
  io.deq.bits  := dataOut

  // Latched credit signal logic
  when (io.deq.credit) {
    icredit := true.B
  }.otherwise {
    icredit := false.B
  }

  // Credit Counter Logic
  when (io.enq.fire() && !io.credit) {
    // Data sent but no credit received, decrement counter
    curCredit := curCredit - 1.U
  }.elsewhen (!io.enq.fire() && io.credit) {
    // No data sent, credit received, increment counter
    curCredit := curCredit + 1.U
  }.elsewhen (io.enq.fire() && io.credit) {
    // Data sent and credit received, no change
    curCredit := curCredit
  }

  // Default signal values for deq interface
  io.deq.credit := io.credit // Forward the credit signal from input
}


