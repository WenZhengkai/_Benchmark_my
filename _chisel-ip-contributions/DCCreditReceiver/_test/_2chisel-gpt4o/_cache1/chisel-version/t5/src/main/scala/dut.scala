import chisel3._
import chisel3.util._

/** CreditIO defines the interface for credit-based flow control */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())    // Indicates that there is valid incoming data
  val credit = Input(Bool())    // Signals when the sender receives credit
  val bits = Output(data.cloneType) // Payload being transmitted of type D

  // CloneType override to support generics
  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

/** DCCreditReceiver module definition */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be a positive integer.")
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))          // Enqueue credit-based input
    val deq = Decoupled(data.cloneType)            // Dequeue decoupled output
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // Tracks FIFO depth
  })

  // Internal FIFO queue
  val fifo = Module(new Queue(data.cloneType, maxCredit))

  // FIFO connections
  fifo.io.enq.valid := false.B
  fifo.io.enq.bits := io.enq.bits
  fifo.io.deq.ready := io.deq.ready

  // Bypass logic
  val bypass = Wire(Bool()) // Indicates whether bypass mode is active
  bypass := fifo.io.count === 0.U && io.enq.valid && io.deq.ready

  // Data/protocol flow
  io.deq.valid := bypass || fifo.io.deq.valid
  io.deq.bits := Mux(bypass, io.enq.bits, fifo.io.deq.bits)

  fifo.io.enq.valid := io.enq.valid && !bypass // Enqueue only if not bypassing
  io.enq.credit := bypass || (fifo.io.deq.valid && io.deq.fire) // Issue credit

  // FIFO count output
  io.fifoCount := fifo.io.count
}
