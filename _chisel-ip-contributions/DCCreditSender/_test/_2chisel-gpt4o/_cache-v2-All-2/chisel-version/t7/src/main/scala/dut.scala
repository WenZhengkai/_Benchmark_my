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
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  /// Task 1: Implement the Credit Register (icredit)
  // Register to capture the credit signal and remember its previous status
  val icredit = RegNext(io.deq.credit, init = false.B)
  
  /// Task 2: Implement the Credit Counter (curCredit)
  // Initialize the credit counter to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Logic to handle credit counting
  when (icredit && !io.deq.valid) {
    curCredit := curCredit + 1.U
  }.elsewhen (io.enq.fire() && !(icredit && !io.deq.valid)) {
    curCredit := curCredit - 1.U
  }

  io.curCredit := curCredit

  /// Task 3: Implement the Ready Signal (io.enq.ready)
  // io.enq.ready is high when there are available credits
  io.enq.ready := curCredit =/= 0.U

  /// Task 4: Implement the Data Register (dataOut) & Valid Register (validOut)
  // Registers for storing data and valid status
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  /// Task 5: Integrate the CreditIO Output Logic
  // Connect the output data and valid signal
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Conditional logic to ensure credits are managed correctly during transfers
  when (io.deq.credit && io.deq.valid) {
    validOut := false.B
  }

  // Make sure credits are replenished correctly when data is dequeued
  when (io.deq.credit) {
    curCredit := curCredit + 1.U
  }
}


