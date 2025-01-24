import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// The DCCreditSender module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val credit = Input(Bool())
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal Registers and Counter (Task 1)
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)
  val icredit = RegInit(false.B)

  // Implement Credit Counter Logic (Task 2)
  when (io.credit && !io.deq.valid) {
    curCreditReg := curCreditReg + 1.U
  } .elsewhen (!io.credit && io.deq.valid) {
    curCreditReg := curCreditReg - 1.U
  }

  // Develop Ready Signal Logic (Task 3)
  io.enq.ready := curCreditReg > 0.U

  // Manage Data Register and Valid Register (Task 4)
  when (io.enq.valid && io.enq.ready) {
    dataOut := io.enq.bits
    validOut := true.B
  } .elsewhen (!validOut || io.credit) {
    validOut := false.B
  }

  // Connect Output Interface (Task 5)
  io.deq.bits := dataOut
  io.deq.valid := validOut
  icredit := io.credit
  io.curCredit := curCreditReg
}

