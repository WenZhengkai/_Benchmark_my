import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataProto: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataProto))
    val deq = new CreditIO(dataProto)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Define Internal Registers & Parameters
  val icredit = RegInit(false.B) // Latched credit signal from dequeue
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Credit counter
  val dataOut = Reg(dataProto.cloneType) // Storage for outgoing data
  val validOut = RegInit(false.B) // Validity of the outgoing data

  // Task 2: Implement Credit Register (icredit)
  icredit := io.deq.credit

  // Task 3: Create Credit Counter Logic
  when (icredit) {
    when (!io.enq.fire()) {
      curCredit := curCredit + 1.U
    }
  } .elsewhen(io.enq.fire()) {
    curCredit := curCredit - 1.U
  }

  // Task 4: Implement the Ready Signal
  io.enq.ready := curCredit > 0.U

  // Task 5: Develop Data & Valid Registers
  when (io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  } .elsewhen(icredit && !io.enq.fire()) {
    validOut := false.B
  }

  // Task 6: Connect Outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Task 7: Set Current Credit Output
  io.curCredit := curCredit
}

// Usage Example:
// val myDCCreditSender = Module(new DCCreditSender(UInt(32.W), 8))
