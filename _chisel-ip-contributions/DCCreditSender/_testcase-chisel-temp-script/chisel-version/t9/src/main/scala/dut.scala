import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, val maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal registers
  val icredit = RegInit(false.B) // Latched credit signal
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W)) // Current credit counter
  
  // Update internal credit register
  when (icredit || io.deq.credit) {
    icredit := io.deq.credit
  }
  
  // Logic for the credit counter
  when(io.enq.fire && !icredit) {
    // Decrement credit on successful send of data
    curCreditReg := curCreditReg - 1.U
  } .elsewhen(icredit && !io.enq.fire) {
    // Increment credit when credit signal is received and no data is sent
    curCreditReg := curCreditReg + 1.U
  }
  
  // Output current available credits
  io.curCredit := curCreditReg
  
  // Data and valid register for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, init = false.B)
  
  // Output logic
  io.deq.bits := dataOut
  io.deq.valid := validOut
  
  // Determine when ready to accept new data
  io.enq.ready := curCreditReg > 0.U
}


