import chisel3._
import chisel3.util._

// Define a CreditIO bundle based on specifications
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the DCCreditSender module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = new CreditIO(data.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Implement Credit Register (`icredit`)
  // Maintain a latch register for the credit signal from the deq interface
  val icredit = RegInit(false.B)
  icredit := io.deq.credit

  // Task 2: Implement Credit Counter (`curCredit`)
  // Register to track current available credits
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  // Update credit count based on enqueue/dequeue events
  when (io.enq.fire && !icredit) {
    // Decrement credit when data is enqueued and no credit is available
    curCreditReg := curCreditReg - 1.U
  } .elsewhen (icredit && !io.enq.fire) {
    // Increment credit when credit is available and no data is enqueued
    curCreditReg := curCreditReg + 1.U
  }

  // Ensure credit stays within bounds
  curCreditReg := curCreditReg.max(0.U).min(maxCredit.U)
  io.curCredit := curCreditReg

  // Task 3: Define Ready Signal (`io.enq.ready`)
  // Ready to accept new data when curCredit is greater than 0
  io.enq.ready := curCreditReg > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  // Registers for managing data output and valid status
  val dataOut = RegEnable(io.enq.bits, 0.U.asTypeOf(data.cloneType), io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // The connection for `io.deq.credit` is implicitly handled through icredit in Task 1
}

// You can define a testbench or additional code to instantiate and simulate the DCCreditSender as needed
