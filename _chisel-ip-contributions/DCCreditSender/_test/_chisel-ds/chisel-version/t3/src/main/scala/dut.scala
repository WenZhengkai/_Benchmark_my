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

  // Internal registers
  val icredit = RegInit(false.B) // Credit register
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W)) // Credit counter
  val dataOut = RegEnable(io.enq.bits, io.enq.fire) // Data register
  val validOut = RegNext(io.enq.fire, false.B) // Valid register

  // Credit logic
  icredit := io.deq.credit

  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U // Increment credit count when credit is received and no data is sent
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U // Decrement credit count when data is sent and no credit is received
  }

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Dequeue interface logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Output current credit
  io.curCredit := curCredit
}

/*
object dut extends App {
  // Example instantiation with UInt(8.W) as data type and maxCredit = 4
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W), 4), args)
}
*/
