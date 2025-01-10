import chisel3._
import chisel3.util._

/** CreditIO interface used for the enq side (incoming data with credit-based flow control). */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())      // Indicates valid incoming data
  val credit = Input(Bool())      // Indicates credits are available
  val bits = Output(data.cloneType) // Data payload
}

/** The DCCreditReceiver module. */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data)) // Incoming credit-based interface
    val deq = Decoupled(data)             // Outgoing decoupled interface
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // FIFO element count
  })

  // Internal FIFO queue
  val fifo = Module(new Queue(chiselTypeOf(data), maxCredit))

  // Wire up the FIFO internals
  fifo.io.enq.valid := io.enq.valid // Valid signal comes from input
  fifo.io.enq.bits := io.enq.bits   // Incoming data payload
  fifo.io.deq.ready := io.deq.ready // Downstream consumes data when ready

  // FIFO queue management: current valid and ready signals
  val fifoEmpty = !fifo.io.deq.valid
  val bypassValid = io.enq.valid && fifoEmpty   // Bypass valid when FIFO is empty and input is valid
  val bypassData = io.enq.bits                 // Bypass data (direct from input)
  val bypassReady = io.deq.ready               // Bypass ready (directly from downstream)

  // Decouple logic: Bypass path or FIFO path
  io.deq.valid := Mux(fifoEmpty, bypassValid, fifo.io.deq.valid) // Valid depending on bypass or FIFO
  io.deq.bits := Mux(fifoEmpty, bypassData, fifo.io.deq.bits)    // Data depending on bypass or FIFO

  // Credit-based flow control (inform the sender when data is consumed)
  io.enq.credit := Mux(fifoEmpty, bypassReady, fifo.io.enq.ready) // Credit signal depending on bypass or FIFO

  // FIFO count exposed as output
  io.fifoCount := fifo.io.count // The count of elements currently in the FIFO
}

