package sender
import chisel3._
import chisel3.util._

// Define the CreditIO class as described
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the DCCreditSender module with specified parameters
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Enqueue interface for incoming data
    val deq = new CreditIO(data)       // Dequeue interface for outgoing data
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register
  val icredit = RegInit(false.B)

  // Internal credit counter, initialized to maxCredit
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Define the ready signal for the enqueue interface
  io.enq.ready := creditCounter > 0.U

  // Update the internal credit register
  icredit := io.deq.credit

  // Logic to handle credit increment/decrement
  when(io.enq.fire() && !icredit) {
    // Data is successfully enqueued, decrement credit
    creditCounter := creditCounter - 1.U
  }.elsewhen(icredit && !io.enq.fire()) {
    // Credit received without sending data, increment credit
    creditCounter := creditCounter + 1.U
  }

  // Hold the current credit count for output
  io.curCredit := creditCounter

  // Temporary registers for holding data and valid status
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  // Setup the output interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
}

