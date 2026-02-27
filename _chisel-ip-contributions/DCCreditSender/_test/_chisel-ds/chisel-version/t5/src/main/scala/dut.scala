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

  // Internal credit register
  val icredit = RegInit(false.B)

  // Credit counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  // Data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Update credit counter logic
  when(icredit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Update icredit register
  icredit := io.deq.credit

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Dequeue output logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Current credit output
  io.curCredit := curCredit
}

// Example usage
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W), maxCredit = 4))
}
*/
