import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, val maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal state
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Credit register to latch credit signal
  val icredit = RegNext(io.deq.credit, init = false.B)

  // Enqueue ready when there is available credit
  io.enq.ready := curCredit > 0.U

  // Dequeue output logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Manage curCredit counter
  when(io.deq.credit && !io.enq.fire()) {
    // Credit received, no data sent
    curCredit := curCredit + 1.U
  }.elsewhen(io.enq.fire() && !io.deq.credit) {
    // Data sent, no credit received
    curCredit := curCredit - 1.U
  }

  // Control the data output and valid flag
  when(io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  }.otherwise {
    validOut := false.B
  }

  io.curCredit := curCredit
}

