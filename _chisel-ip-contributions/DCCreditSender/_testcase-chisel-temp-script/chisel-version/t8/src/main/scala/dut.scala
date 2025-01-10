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
    val credit = Input(Bool())
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })
  
  // Internal credit counter
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  io.curCredit := curCreditReg

  // Data and valid registers
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)
  
  // Latch the data to be sent out once valid
  when(io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.credit) {
    validOut := false.B
  }
  
  // Assign outputs
  io.enq.ready := curCreditReg =/= 0.U
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Internal credit management logic
  when(io.credit && !validOut) {
    // Credit received, increment available credits
    curCreditReg := curCreditReg + 1.U
  }.elsewhen(validOut && !io.credit) {
    // Data sent, decrement available credits
    curCreditReg := curCreditReg - 1.U
  }
}
