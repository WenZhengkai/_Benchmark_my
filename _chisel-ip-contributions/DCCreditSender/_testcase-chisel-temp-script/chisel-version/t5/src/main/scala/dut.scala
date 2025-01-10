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

  // Internal credit counter register
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  // Internal data and valid registers for output
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Latch the credit signal for internal usage
  val iCredit = Wire(Bool())
  iCredit := io.deq.credit

  // Default output connections
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit

  // Manage the enqueue ready signal
  io.enq.ready := curCredit > 0.U

  when(io.enq.fire()) {
    // Enqueue event: consume a credit and latch data
    curCredit := curCredit - 1.U
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(iCredit && !validOut) {
    // Credit received from receiver without enqueueing new data
    curCredit := curCredit + 1.U
  }

  // Manage output valid signal
  when(io.deq.credit && validOut) {
    // Data has been sent, clear the valid signal
    validOut := false.B
  }
}

