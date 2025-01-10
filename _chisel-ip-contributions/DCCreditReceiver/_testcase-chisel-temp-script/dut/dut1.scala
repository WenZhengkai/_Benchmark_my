import chisel3._
import chisel3.util._

/** CreditIO Interface - Represents the credit-based flow control interface */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())   // Indicates if the incoming data is valid.
  val credit = Input(Bool())   // Signal from the receiver indicating it is ready for more data (credit returned).
  val bits = Output(data.cloneType) // The data payload.
}

/** DCCreditReceiver Module */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))         // Incoming credit-based interface.
    val deq = Decoupled(data.cloneType)           // Outgoing decoupled interface.
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // Number of elements in the FIFO buffer.
  })

  // Internal FIFO Queue
  val fifo = Module(new Queue(data, maxCredit))

  // Wires and Registers
  val bypassMode = Wire(Bool())                // Whether the bypass mode is enabled (FIFO is empty).
  val nextCredit = Wire(Bool())                // Determines when a credit should be issued.
  val ocredit = RegInit(false.B)               // Output credit signal (will drive io.enq.credit).

  // Bypass Logic: FIFO is empty and the consumer is ready
  bypassMode := fifo.io.count === 0.U && io.deq.ready

  // Connecting the FIFO enqueue logic
  fifo.io.enq.valid := io.enq.valid && !bypassMode // Push to FIFO only when not bypassing
  fifo.io.enq.bits := io.enq.bits

  // Connecting the FIFO dequeue logic
  fifo.io.deq.ready := io.deq.ready // FIFO ready when downstream is ready

  // Connecting the output dequeue logic
  io.deq.valid := Mux(bypassMode, io.enq.valid, fifo.io.deq.valid) // Use FIFO or bypass
  io.deq.bits := Mux(bypassMode, io.enq.bits, fifo.io.deq.bits) // Use FIFO or bypass

  // Credit generation logic: When to issue a credit back to the sender
  nextCredit := Mux(bypassMode, io.deq.fire, fifo.io.deq.fire)
  ocredit := nextCredit

  // Connecting Credit Output
  io.enq.credit := ocredit

  // Connecting FIFO count output
  io.fifoCount := fifo.io.count
}

