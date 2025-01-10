import chisel3._
import chisel3.util._

/** CreditIO Interface for Credit-based Flow Control */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)

  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

/** DCCreditSender Module Implementation */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    // Input interface
    val enq = Flipped(Decoupled(data)) // Enqueue interface
    val credit = Input(Bool())        // Credit signal from the receiver

    // Output interface
    val deq = new CreditIO(data)          // Dequeue interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credit count
  })

  // Internal credit counter register
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Credit signal synchronization (for dequeue credit tracking)
  val icredit = RegNext(io.credit, false.B)

  // Temporary storage for the output data and valid signal
  val dataOut = Reg(data)
  val validOut = RegInit(false.B)

  // Connect Dequeue Output
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Enqueue readiness: Ready to accept new data if credits are available
  io.enq.ready := curCredit > 0.U

  // Default logic for validOut (put valid output high when sending data)
  when(io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.valid && icredit) {
    validOut := false.B
  }

  // Credit Counter Logic
  when(io.enq.valid && io.enq.ready) {
    // Data is sent: Decrement the credit counter
    curCredit := curCredit - 1.U
  }.elsewhen(io.deq.valid && io.credit) {
    // Credit is received: Increment the credit counter
    curCredit := curCredit + 1.U
  }

  // Connect curCredit to output
  io.curCredit := curCredit
}

