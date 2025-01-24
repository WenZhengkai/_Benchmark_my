import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Define Internal Registers & Parameters
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  val dataOut = RegInit(0.U.asTypeOf(data))
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Register (icredit)
  icredit := io.deq.credit

  // Task 3: Create Credit Counter Logic
  when(io.deq.credit && !io.enq.ready) {
    // Increment credit
    curCredit := curCredit + 1.U
  } .elsewhen(io.enq.fire()) {
    // Decrement credit
    curCredit := curCredit - 1.U
  }

  // Task 4: Implement the Ready Signal
  io.enq.ready := curCredit > 0.U

  // Task 5: Develop Data & Valid Registers
  when(io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  } .elsewhen(io.deq.credit) {
    validOut := false.B
  }

  // Task 6: Connect Outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Task 7: Set Current Credit Output
  io.curCredit := curCredit
}
