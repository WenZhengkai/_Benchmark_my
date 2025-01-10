import chisel3._
import chisel3.util._

/** CreditIO bundle for credit-based flow control communication */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())        // Output flag signaling valid data
  val credit = Input(Bool())        // Input flag signaling credit request
  val bits = Output(data.cloneType) // Data payload to be sent

  // CloneType override for the case of parametrized internal elements
  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

/** DCCreditSender Module */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))     // Enqueue interface (input)
    val deq = new CreditIO(data)          // Dequeue/output interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current available credits
  })

  // === Registers ===
  
  // Current credit count (initialized to maxCredit)
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  
  // Latches the credit signal (icredit)
  val icredit = RegInit(false.B)
  icredit := io.deq.credit

  // Data register for the output
  val dataOut = Reg(data.cloneType)
  
  // Validity register for output data
  val validOut = RegInit(false.B)

  // === Logic ===

  // Ready signal: Only ready to accept new data if credits are available
  io.enq.ready := curCreditReg > 0.U

  // Output valid flag
  io.deq.valid := validOut

  // Data payload output
  io.deq.bits := dataOut

  // Current credits available
  io.curCredit := curCreditReg

  when(io.deq.credit && !validOut) {
    // Increment credit if no data is being sent but a credit is received
    curCreditReg := curCreditReg + 1.U
  }.elsewhen(io.enq.valid && io.enq.ready) {
    // Update output registers when enq is valid and ready
    dataOut := io.enq.bits // Capture the enqueue data
    validOut := true.B     // Signal that valid data is ready to be dequeued
    curCreditReg := curCreditReg - 1.U // Decrement the available credit counter
  }.elsewhen(io.deq.valid && io.deq.credit) {
    // Clear the valid signal when data is dequeued
    validOut := false.B
  }
}
