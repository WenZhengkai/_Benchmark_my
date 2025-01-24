import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Define Internal Registers & Parameters
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  val dataOut = Reg(dataType.cloneType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Register (icredit)
  icredit := io.deq.credit

  // Task 3: Create Credit Counter Logic
  when(io.deq.credit && !io.enq.valid) {
    // Increment credit if credit received and not enqueueing
    curCredit := curCredit + 1.U
  }.elsewhen(io.enq.fire() && !io.deq.credit) {
    // Decrement credit if enqueueing and not receiving credit
    curCredit := curCredit - 1.U
  }

  // Task 4: Implement the Ready Signal
  io.enq.ready := curCredit > 0.U

  // Task 5: Develop Data & Valid Registers
  when(io.enq.fire()) {
    dataOut := io.enq.bits
  }
  validOut := io.enq.fire()

  // Task 6: Connect Outputs
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Task 7: Set Current Credit Output
  io.curCredit := curCredit
}

// Testbench and other components would be needed to exercise this module in a simulation.
