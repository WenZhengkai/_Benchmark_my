import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, val maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  // Width of the credit counter
  val creditWidth = log2Ceil(maxCredit)

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))                // Input enqueue interface
    val credit = Input(Bool())                       // Input credit signal
    val deq = new CreditIO(data)                     // Output dequeue interface
    val curCredit = Output(UInt(creditWidth.W))      // Current available credits
  })

  // Registers
  val curCredit = RegInit(maxCredit.U(creditWidth.W)) // Credit counter register
  val dataOut = Reg(data.cloneType)                   // Output data register
  val validOut = RegInit(false.B)                     // Output valid register

  // Internal latch for credit signal
  val icredit = RegNext(io.credit, init = false.B)

  // Enqueue interface logic
  io.enq.ready := curCredit > 0.U && !validOut

  // Update credit counter
  when(io.credit && !icredit) {
    curCredit := curCredit + 1.U     // Increment credit when credit is received
  }

  when(io.enq.fire()) {
    curCredit := curCredit - 1.U     // Decrement credit when data is enqueued
  }

  // Output data and valid register updates
  when(io.enq.fire()) {
    dataOut := io.enq.bits          // Capture data from enqueue interface
    validOut := true.B              // Set valid output when data is captured
  }.elsewhen(io.deq.credit) {
    validOut := false.B             // Clear valid output when credit is received and data is consumed
  }

  // Dequeue interface signals
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Output current credit value
  io.curCredit := curCredit
}


