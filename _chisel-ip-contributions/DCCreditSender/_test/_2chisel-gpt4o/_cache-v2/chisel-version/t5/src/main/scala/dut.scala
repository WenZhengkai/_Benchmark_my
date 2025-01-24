import chisel3._
import chisel3.util._

// Define the CreditIO interface using the given data type
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// DCCreditSender module with parameters for data type and maximum credit
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  // Define the input/output interfaces
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = new CreditIO(data.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal Registers
  val icredit = RegInit(false.B)            // Credit latch
  val curCredit = RegInit(maxCredit.U)      // Credit counter initialized to maxCredit
  val dataOut = Reg(data.cloneType)         // Temporary data register for dequeue
  val validOut = RegInit(false.B)           // Valid register

  // Enqueue readiness is determined by available credits
  io.enq.ready := curCredit > 0.U

  // Capturing the credit signal
  when (io.deq.credit) {
    icredit := true.B
  }.otherwise {
    icredit := false.B
  }

  // Logic for handling data enqueue and dequeue
  when (io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
    curCredit := curCredit - 1.U // Decrement credit on data enqueue
  }

  when (io.deq.credit && validOut) {
    validOut := false.B
    when (!io.enq.valid || !io.enq.ready) { 
      curCredit := curCredit + 1.U // Increment credit when credit is received and no new data is enqueued
    }
  }

  // Output assignments
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := curCredit
}

