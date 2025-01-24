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
    val credit = Input(Bool())
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Define Internal Registers and Counter
  // - Create a register to maintain the current credit count (curCredit). Initialize it to maxCredit.
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  // - Define the icredit register to store the latched status of the dequeue credit signal.
  val icredit = RegNext(io.credit, init = false.B)
  // - Create temporary registers dataOut and validOut for holding outgoing data payloads and their validity.
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  // - Increment curCredit when a credit is received (credit signal is high)
  //   and no data is dequeued.
  // - Decrement curCredit when data is dequeued successfully (data sent out
  //   and credit is not received).
  when(io.credit && !io.deq.valid) {
    curCreditReg := curCreditReg + 1.U
  }.elsewhen(io.deq.valid && !io.credit) {
    curCreditReg := curCreditReg - 1.U
  }

  // Task 3: Develop Ready Signal Logic
  // - Assign io.enq.ready to true when curCredit is greater than zero.
  io.enq.ready := curCreditReg > 0.U

  // Task 4: Manage Data Register and Valid Register
  // - Use RegEnable to capture data from the enqueue interface when
  //   io.enq.valid and io.enq.ready are both true.
  when(io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  }.otherwise {
    validOut := false.B
  }

  // Task 5: Connect Output Interface
  // - Connect deq.bits to dataOut for sending the data payload.
  // - Connect deq.valid to validOut to reflect the validity of the outgoing data.
  // - Reflect the incoming credit signal to the internal icredit if necessary
  //   for any additional logic.
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCreditReg
}

