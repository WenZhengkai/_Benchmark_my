import chisel3._
import chisel3.util._

/**
 * A specialized IO bundle for credit-based flow control.
 * @param data A Chisel Data type (e.g., UInt, Bundle, etc.) for the payload.
 */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())       // Output indicating that the data is valid.
  val credit = Input(Bool())       // Input from the receiver indicating credits are available.
  val bits = Output(data.cloneType) // The actual data being transmitted.
}

/**
 * The dut module implements a credit-based flow control sender.
 * @param data The data type of the enqueue and dequeue interface.
 * @param maxCredit Maximum number of credits the sender can hold.
 */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1.") // Parameter check.

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))     // Enqueue interface for incoming data.
    val deq = new CreditIO(data)          // Dequeue interface for outgoing data.
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credit count.
  })

  // Task 1: Credit Register (icredit)
  // This register holds the previous cycle's value of `io.deq.credit`.
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Credit Counter (curCredit)
  // This counter tracks the available credits.
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  when(icredit && !io.enq.fire) { // Increment credit when credit is received and no enqueue operation.
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) { // Decrement credit when enqueue operation happens without a credit update.
    curCredit := curCredit - 1.U
  }

  // Connect current credit to the output.
  io.curCredit := curCredit

  // Task 3: Ready Signal (io.enq.ready)
  // The enqueue interface is ready only if there are available credits.
  io.enq.ready := (curCredit > 0.U)

  // Task 4: Data Register (dataOut)
  // This register holds the last valid data when io.enq.fire is true.
  val dataOut = RegEnable(io.enq.bits, enable = io.enq.fire)

  // Task 5: Valid Register (validOut)
  // This register tracks whether the data is currently valid to send.
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Connect output fields of the dequeue interface.
  io.deq.valid := validOut              // Output the valid signal.
  io.deq.bits := dataOut                // Output the last valid data.
}
