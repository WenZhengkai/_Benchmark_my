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
    val enq = Flipped(Decoupled(data)) // Enqueue interface
    val deq = new CreditIO(data)       // Dequeue interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Initialize to maxCredit

  // Internal credit signal (latched)
  val icredit = RegNext(io.deq.credit, init = false.B) // Register to latch the dequeue credit signal

  // Registers for output data payload and valid status
  val dataOut = RegEnable(io.enq.bits, io.enq.valid && io.enq.ready) // Register to hold enqueued data
  val validOut = RegNext(io.enq.valid && io.enq.ready, init = false.B) // Valid register, tracks enqueue status

  // When enqueue happens and icredit is false (no credit received this cycle), subtract 1 from curCredit
  when(io.enq.valid && io.enq.ready && !icredit) {
    curCredit := curCredit - 1.U
  }

  // When a credit is received and no enqueue happens, add 1 to curCredit
  when(io.deq.credit && !(io.enq.valid && io.enq.ready)) {
    curCredit := curCredit + 1.U
  }

  // Enqueue ready signal - can accept data only when credits are available
  io.enq.ready := curCredit > 0.U

  // Output valid signal - follows the validOut register
  io.deq.valid := validOut

  // Output data - follows the dataOut register
  io.deq.bits := dataOut

  // Pass-through the received credit signal
  // This connects to the receiver logic in your system
  io.curCredit := curCredit // Expose the current credit count
}
