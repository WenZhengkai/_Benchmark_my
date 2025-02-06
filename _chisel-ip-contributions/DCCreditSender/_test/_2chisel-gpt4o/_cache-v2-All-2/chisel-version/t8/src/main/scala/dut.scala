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

  // Task 1: Implement the Credit Register (icredit)
  val icredit = RegNext(io.deq.credit, false.B)

  // Task 2: Implement the Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  when(io.deq.credit && !io.enq.ready) {
    // Increment credit counter when credit is granted and new data is not written.
    curCredit := curCredit + 1.U
  }.elsewhen(!io.deq.credit && io.enq.fire()) {
    // Decrement credit counter when data is dequeued without receiving new credit.
    curCredit := curCredit - 1.U
  }

  // Output the current credit count
  io.curCredit := curCredit

  // Task 3: Implement the Ready Signal (io.enq.ready)
  io.enq.ready := curCredit =/= 0.U

  // Task 4: Implement the Data Register (dataOut) & Valid Register (validOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)

  // Task 5: Integrate the CreditIO Output Logic
  io.deq.bits := dataOut
  io.deq.valid := validOut && icredit

  when(io.enq.fire()) {
    // Capture new data when enqueuing
    dataOut := io.enq.bits
  }
}

// Testbench (simplified example, not complete for production use)