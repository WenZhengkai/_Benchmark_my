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
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Credit counter (initially set to maxCredit)
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Internal credit register
  val icredit = RegNext(io.deq.credit, false.B)

  // Enqueue ready signal
  io.enq.ready := curCreditReg > 0.U

  // Data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), false.B)
  
  // Connect output interface
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Credit logic for curCreditReg
  when(io.enq.fire() && !io.deq.credit) {
    // Data enqueued and no credit received - decrement credit counter
    curCreditReg := curCreditReg - 1.U
  }.elsewhen(!io.enq.fire() && io.deq.credit) {
    // Credit received but no data enqueued - increment credit counter
    curCreditReg := curCreditReg + 1.U
  }

  // Output current credit value
  io.curCredit := curCreditReg
}

