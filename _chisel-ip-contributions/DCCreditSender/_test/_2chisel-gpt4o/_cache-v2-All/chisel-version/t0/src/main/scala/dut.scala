import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](val data: D, val maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // ---------- Task 1: Define Internal Registers & Parameters ----------
  // Registers to manage credit and data
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit+1).W))
  
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // ---------- Task 2: Implement Credit Register (icredit) ----------
  // Track the last known state of the dequeue's credit signal
  icredit := io.deq.credit

  // ---------- Task 3: Create Credit Counter Logic ----------
  // Manage curCredit: increment when credit is received, decrement on enqueue
  when (io.deq.credit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  }.elsewhen (!io.deq.credit && io.enq.fire()) {
    curCredit := curCredit - 1.U
  }

  // ---------- Task 4: Implement the Ready Signal ----------
  // Determine readiness to enqueue new data
  io.enq.ready := curCredit > 0.U

  // ---------- Task 5: Develop Data & Valid Registers ----------
  // Manage the storage and valid status of data payloads
  when (io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.valid && io.deq.credit) {
    validOut := false.B
  }

  // ---------- Task 6: Connect Outputs ----------
  // Connect components to the CreditIO interface
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // ---------- Task 7: Set Current Credit Output ----------
  // Output the current credit count
  io.curCredit := curCredit
}

