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
    val credit = Input(Bool())
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Task 1: Define Internal Registers and Counter
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val icredit = RegInit(false.B)
  
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Task 2: Implement Credit Counter Logic
  when(io.credit) {
    when(!io.deq.valid || (io.deq.valid && io.deq.credit)) {
      curCredit := curCredit + 1.U
    }.elsewhen(io.deq.valid && !io.deq.credit) {
      curCredit := curCredit
    }
  }.otherwise {
    when(io.deq.valid && !io.deq.credit) {
      curCredit := curCredit - 1.U
    }
  }

  // Task 3: Develop Ready Signal Logic
  io.enq.ready := curCredit > 0.U

  // Task 4: Manage Data Register and Valid Register
  when(io.enq.fire()) {
    dataOut := io.enq.bits
    validOut := true.B
  }.otherwise {
    when(io.deq.credit) {
      validOut := false.B
    }
  }

  // Task 5: Connect Output Interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  icredit := io.credit

  // Output Current Credit
  io.curCredit := curCredit
}
