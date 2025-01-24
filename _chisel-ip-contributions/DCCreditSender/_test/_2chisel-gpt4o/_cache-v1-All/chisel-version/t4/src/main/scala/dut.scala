import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, val maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val credit = Input(Bool())
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Define Internal Registers and Counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  val icredit = RegNext(io.credit, false.B)
  val dataOut = Reg(dataType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  when(io.credit && !validOut) {
    curCredit := curCredit + 1.U
  } .elsewhen(validOut && !io.credit) {
    curCredit := curCredit - 1.U
  }

  // Task 3: Develop Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Task 4: Manage Data Register and Valid Register
  when(io.enq.valid && io.enq.ready) {
    validOut := true.B
    dataOut := io.enq.bits
  } .otherwise {
    validOut := false.B
  }

  // Task 5: Connect Output Interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  // Reflects if any additional logic requires it, otherwise, doesn't need to connect.
  io.deq.credit := io.credit
  io.curCredit := curCredit
}

// Example usage of the DCCreditSender module
