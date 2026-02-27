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

  // Credit Register (icredit)
  val icredit = RegInit(false.B)

  // Credit Counter (curCredit)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Ready Signal (io.enq.ready)
  io.enq.ready := curCredit > 0.U

  // Data Register (dataOut) & Valid Register (validOut)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Credit Logic
  when(io.deq.credit && !io.enq.fire) {
    curCredit := curCredit + 1.U
  }.elsewhen(!io.deq.credit && io.enq.fire) {
    curCredit := curCredit - 1.U
  }

  // Dequeue Interface Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Current Credit Output
  io.curCredit := curCredit

  // Latch the credit signal
  icredit := io.deq.credit
}

// Testbench for dut
class dutTest extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(UInt(8.W)))
    val deq = new CreditIO(UInt(8.W))
    val curCredit = Output(UInt(log2Ceil(8).W))
  })

  val dut = Module(new dut(UInt(8.W), 8))

  dut.io.enq <> io.enq
  io.deq <> dut.io.deq
  io.curCredit := dut.io.curCredit
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W), 8), Array("--target-dir", "generated"))
}
*/
