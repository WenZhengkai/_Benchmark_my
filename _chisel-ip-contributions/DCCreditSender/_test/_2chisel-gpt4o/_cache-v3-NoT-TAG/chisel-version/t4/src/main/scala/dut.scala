import chisel3._
import chisel3.util._

// Definition of CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())       // Output validity signal
  val credit = Input(Bool())       // Input credit signal
  val bits = Output(data.cloneType) // Data being sent
}

// dut Module Definition
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))  // enq interface
    val deq = new CreditIO(data)       // deq interface
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credits available
  })

  // Task 1: Credit Register (icredit)
  // Latches the credit signal from io.deq.credit
  val icredit = RegNext(io.deq.credit, init = false.B) // Initialize to false to avoid undefined behavior

  // Task 2: Credit Counter (curCredit)
  // Counter to manage the available credits
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Initialize to maximum credit
  
  when(icredit && !io.enq.fire) {
    // Increment credit when a credit is received and no data is being sent
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    // Decrement credit when data is being sent and no credit is received
    curCredit := curCredit - 1.U
  }

  io.curCredit := curCredit // Connect to the output interface

  // Task 3: Ready Signal (io.enq.ready)
  // Indicate readiness to accept new data based on available credits
  io.enq.ready := curCredit > 0.U

  // Task 4: Data Register (dataOut)
  // Register to store incoming data when enq.fire is asserted
  val dataOut = RegEnable(io.enq.bits, enable = io.enq.fire)

  // Task 5: Valid Register (validOut)
  // Register to track the validity of the output data
  val validOut = RegNext(io.enq.fire, init = false.B) // Initialize to false.B

  // Connect dataOut and validOut to the deq interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
}

// Example instantiation of the dut module
