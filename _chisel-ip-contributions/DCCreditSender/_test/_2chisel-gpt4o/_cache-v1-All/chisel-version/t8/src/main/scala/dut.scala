import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val bits = Output(data.cloneType)
  val valid = Output(Bool())
  val credit = Input(Bool())
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W)) // Allow for a bit extra margin
  })

  // Task 1: Define Internal Registers and Counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)
  val icredit = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  when(io.deq.valid && !io.deq.credit) {
    // Decrement credit when data is sent and no credit received
    curCredit := curCredit - 1.U
  }.elsewhen(io.credit && !io.deq.valid) {
    // Increment credit when credit is received and no data is sent
    curCredit := Mux(curCredit < maxCredit.U, curCredit + 1.U, curCredit)
  }

  // Task 3: Develop Ready Signal Logic
  io.enq.ready := (curCredit > 0.U)

  // Task 4: Manage Data Register and Valid Register
  when(io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  }.elsewhen(io.deq.valid && io.deq.credit) {
    validOut := false.B
  }

  // Task 5: Connect Output Interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := curCredit

  // Reflect incoming credit signal if necessary (for task logic completeness)
  when(io.deq.credit) {
    icredit := true.B
  }.otherwise {
    icredit := false.B
  }
}
