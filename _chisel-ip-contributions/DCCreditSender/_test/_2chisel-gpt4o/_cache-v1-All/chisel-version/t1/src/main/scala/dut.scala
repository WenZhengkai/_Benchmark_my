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
    val enq = Flipped(Decoupled(data))  // Input interface for enqueue
    val credit = Input(Bool())          // Input signal for received credit
    val deq = new CreditIO(data)        // Output interface for dequeue
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))  // Output for current credit count
  })

  // Task 1: Define Internal Registers and Counter
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val icredit = RegInit(false.B)
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  when(io.credit && !validOut) {
    // Increment credit when a credit is received and no data is being dequeued
    curCreditReg := curCreditReg + 1.U
  } .elsewhen(validOut && !io.credit) {
    // Decrement credit when data is dequeued successfully and no credit is received
    curCreditReg := curCreditReg - 1.U
  }

  // Task 3: Develop Ready Signal Logic
  io.enq.ready := curCreditReg > 0.U

  // Task 4: Manage Data Register and Valid Register
  when(io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  } .otherwise {
    validOut := false.B
  }

  // Task 5: Connect Output Interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCreditReg

  // Extra: Reflect the incoming credit signal to the internal icredit (if extra logic is needed)
  icredit := io.credit
}
