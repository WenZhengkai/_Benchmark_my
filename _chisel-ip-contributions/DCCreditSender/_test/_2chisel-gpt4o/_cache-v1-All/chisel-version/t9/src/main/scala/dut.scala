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
    val curCredit = Output(UInt(log2Ceil(maxCredit+1).W)) // +1 to handle maxCredit state
  })

  // Task 1: Define Internal Registers and Counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit+1).W)) // Start with max credits
  val icredit = RegNext(io.deq.credit, false.B)
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  when(io.deq.credit && !io.deq.valid) {
    // Increment credit when credit signal is high and no data is dequeued
    curCredit := curCredit + 1.U
  }.elsewhen(io.deq.valid && !io.deq.credit) {
    // Decrement credit when data is dequeued and credit is not received
    curCredit := curCredit - 1.U
  }

  // Task 3: Develop Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Task 4: Manage Data Register and Valid Register
  when(io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.valid && !io.deq.credit) {
    validOut := false.B
  }

  // Task 5: Connect Output Interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  // Reflect credit signal (not strictly necessary for a basic setup but shown if further logic is intended)
  icredit := io.deq.credit

  // Connect current credit to output
  io.curCredit := curCredit
}

