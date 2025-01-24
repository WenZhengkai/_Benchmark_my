import chisel3._
import chisel3.util._

// Definition of the CreditIO bundle
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main module definition
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Enqueue interface
    val deq = new CreditIO(data)       // Dequeue interface
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W)) // Current credit count output
  })

  // Task 1: Define Internal Registers & Parameters
  val icredit = RegInit(false.B) // Register to latch the dequeue credit signal
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W)) // Current available credits
  val dataOut = Reg(data.cloneType) // Register for storing output data
  val validOut = RegInit(false.B) // Register for storing valid status of the output data

  // Task 2: Implement Credit Register (icredit)
  icredit := io.deq.credit

  // Task 3: Create Credit Counter Logic
  when(io.deq.credit && !io.enq.fire()) {
    // Increment credit when a credit is received and no data is enqueued
    curCredit := curCredit + 1.U
  }.elsewhen(io.enq.fire() && !io.deq.credit) {
    // Decrement credit when data is enqueued and no credit is received
    curCredit := curCredit - 1.U
  }

  // Ensure the credit count stays within bounds
  when(curCredit > maxCredit.U) {
    curCredit := maxCredit.U
  }

  // Task 4: Implement the Ready Signal
  io.enq.ready := curCredit > 0.U // Ready when there are available credits

  // Task 5: Develop Data & Valid Registers
  when(io.enq.fire()) { // Update dataOut & validOut when data is enqueued
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.credit && validOut) {
    // Invalidate the output when a credit is received and data was valid
    validOut := false.B
  }

  // Task 6: Connect Outputs
  io.deq.valid := validOut // Output valid status
  io.deq.bits := dataOut   // Output data

  // Task 7: Set Current Credit Output
  io.curCredit := curCredit // Output the current credit count
}


