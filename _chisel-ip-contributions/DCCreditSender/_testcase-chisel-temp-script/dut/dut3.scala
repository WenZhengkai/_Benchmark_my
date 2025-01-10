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
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  io.curCredit := curCredit

  // Credit tracking signal
  val icredit = RegInit(false.B)

  // Register for dequeued data
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Default output assignments
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Input enq interface ready condition
  io.enq.ready := curCredit > 0.U

  // Latch the internal credit signal
  icredit := io.deq.credit

  // Update credit count
  when(io.deq.credit && !validOut) {
    curCredit := curCredit + 1.U
  }
  when(io.enq.valid && io.enq.ready) {
    curCredit := curCredit - 1.U
  }

  // Register-enable for valid and data latch
  when(io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.credit) {
    validOut := false.B
  }
}
