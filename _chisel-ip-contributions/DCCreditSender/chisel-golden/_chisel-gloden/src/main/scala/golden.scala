
import chisel3._
import chisel3.util._

/**
  * Creates a new signal class for sending credit-based flow control.
  *
  * This is useful for building systems which are insensitive to variable latency
  * delays.
  */

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class DCCreditSender[D <: Data](data: D, maxCredit: Int) extends Module {

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = new CreditIO(data.cloneType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })
  require(maxCredit >= 1)

  override def desiredName: String = "DCCreditSender_" + data.toString

  val icredit = RegNext(io.deq.credit)
  val curCredit = RegInit(init = maxCredit.U)

  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  io.enq.ready := curCredit > 0.U

  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)
  
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := curCredit
}


object Driver extends App {
  println("Generating the DCCreditSender hardware")
  emitVerilog(new DCCreditSender(UInt(8.W),5), Array("--target-dir", "generated"))
}