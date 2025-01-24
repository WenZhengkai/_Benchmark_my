import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register to latch the dequeue credit signal
  val icredit = RegInit(false.B)

  // Credit counter initialized to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Ready signal for the enqueue interface
  io.enq.ready := curCredit > 0.U

  // Data register and valid register for the output
  val dataOut = RegEnable(io.enq.bits, io.enq.fire())
  val validOut = RegNext(io.enq.fire(), init = false.B)

  // Logic to handle credits and data flow
  when(io.enq.fire() && io.deq.credit) {
    curCredit := curCredit // Credit and data balance each other
  }.elsewhen(io.enq.fire()) {
    curCredit := curCredit - 1.U // Data sent, reduce credit
  }.elsewhen(io.deq.credit) {
    curCredit := curCredit + 1.U // Credit received, increase credit
  }

  // Hook up the output interface
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.curCredit := curCredit
}
