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
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Register to maintain current credit status
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  // Registers for internal logic
  val icredit = RegInit(false.B)
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)
  
  // Handle enqueue-ready logic
  io.enq.ready := curCredit > 0.U

  // Dequeue interface logic
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Main logic
  when(io.enq.fire()) {
    // Data is enqueued, and validOut set high
    curCredit := curCredit - 1.U
    validOut := true.B
    dataOut := io.enq.bits
  } .otherwise {
    validOut := false.B
  }
  
  when(io.deq.credit && !io.enq.ready) {
    // Increase credit when credit signal is high and no data enqueue
    curCredit := curCredit + 1.U
  }

  // Output current number of credits
  io.curCredit := curCredit
}

// Example Instantiation
/*
object DCCreditSenderGenerator extends App {
  chisel3.Driver.execute(Array[String](), () => new DCCreditSender(UInt(8.W), 16))
}
*/

