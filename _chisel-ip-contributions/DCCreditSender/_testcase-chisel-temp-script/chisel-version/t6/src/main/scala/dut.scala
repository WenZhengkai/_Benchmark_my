import chisel3._
import chisel3.util._

/** CreditIO Bundle definition to represent the dequeue/output interface */
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())  // Indicates if output data is valid
  val credit = Input(Bool())  // Indicates a credit return from the receiver
  val bits = Output(data.cloneType)  // The data payload
}

/** dut Module */
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be greater than or equal to 1")

  // Define I/O Ports
  val io = IO(new Bundle {
    // Enqueue interface for input data
    val enq = Flipped(Decoupled(data))
    // Dequeue interface for output data (credit-based)
    val deq = new CreditIO(data)
    // Current credit status (informational output)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Credit Register (icredit)
  // Register to latch the credit signal from io.deq.credit
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Task 2: Credit Counter (curCredit)
  // Register to track the current number of credits available
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Increment or decrement credit counter based on conditions
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U // Increment credit
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U // Decrement credit
  }

  // Expose the current credit status to the outside
  io.curCredit := curCredit

  // Task 3: Ready Signal (io.enq.ready)
  // Indicate if the module is ready to accept input data
  io.enq.ready := curCredit > 0.U

  // Task 4: Data Register (dataOut)
  // Register to hold the data when enq.fire is asserted
  val dataOut = RegEnable(io.enq.bits, enable = io.enq.fire)

  // Task 5: Valid Register (validOut)
  // Register to maintain the valid flag for the output data
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Connect output interface fields
  io.deq.valid := validOut
  io.deq.bits := dataOut
}
