import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)

  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be at least 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register and counter
  val icredit = RegNext(io.deq.credit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Data and Valid registers for output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire)

  // Logic for dequeue interface signals
  io.deq.bits := dataOut
  io.deq.valid := validOut

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Logic for credit counter
  when (icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  } .elsewhen (!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Connect output credit count
  io.curCredit := curCredit
}
