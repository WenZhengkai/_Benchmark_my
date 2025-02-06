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

  // Credit Counter initialized to maxCredit
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Credit Register
  val icredit = io.deq.credit

  // Ready Signal
  io.enq.ready := curCredit > 0.U

  // Data Register and Valid Register
  val dataOut = RegEnable(io.enq.bits, 0.U.asTypeOf(data), io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Assign outputs
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit

  // Update curCredit
  when(icredit && !io.enq.fire) {
    // Received a credit, increment curCredit if enq.fire is low
    curCredit := curCredit + 1.U
  }.elsewhen(!icredit && io.enq.fire) {
    // Sent data, decrement curCredit if credit is low and enq.fire is high
    curCredit := curCredit - 1.U
  }
}

// Test bench and additional code would be required to completely validate this module.
