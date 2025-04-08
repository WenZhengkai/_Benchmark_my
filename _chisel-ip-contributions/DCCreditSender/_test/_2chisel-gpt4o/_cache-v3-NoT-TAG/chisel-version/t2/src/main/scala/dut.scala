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
    val enq = Flipped(Decoupled(data)) // Input interface for enqueuing data
    val deq = new CreditIO(data)       // Output interface with valid, credit, and data
    val curCredit = Output(UInt(log2Ceil(maxCredit).W)) // Current credit count display
  })

  // === Task 1: Credit Register (icredit) ===
  // Latch the credit signal from `io.deq.credit`
  val icredit = RegNext(io.deq.credit, false.B) // Initialize to `false.B`

  // === Task 2: Credit Counter (curCredit) ===
  // Register to track the number of credits available
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Update `curCredit` based on credit and enqueue conditions
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U // Increment when credit is high and no enqueue
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U // Decrement when credit is low and enqueue occurs
  }

  // Display the current credit count through the `io.curCredit` output
  io.curCredit := curCredit

  // === Task 3: Ready Signal (io.enq.ready) ===
  // Drive `io.enq.ready` based on available credits
  io.enq.ready := curCredit > 0.U

  // === Task 4: Data Register (dataOut) ===
  // Store incoming data when `enq.fire` is asserted
  val dataOut = RegEnable(io.enq.bits, io.enq.fire) // Captures `enq.bits` when `enq.fire` is true

  // === Task 5: Valid Register (validOut) ===
  // Maintain a valid flag for the output data
  val validOut = RegNext(io.enq.fire, false.B) // Tracks if the outgoing data is valid

  // === Connecting Outputs ===
  io.deq.bits := dataOut // Output the stored data
  io.deq.valid := validOut // Output the valid signal
}
