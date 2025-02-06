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

  // Internal Registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val dataOut = Reg(data.cloneType)
  val validOut = RegInit(false.B)

  // Logic to update credit and data registers
  when(io.enq.fire() && curCredit =/= 0.U) {
    dataOut := io.enq.bits
    validOut := true.B
    curCredit := curCredit - 1.U
  }.otherwise {
    validOut := false.B
  }

  when(io.deq.credit && !io.enq.fire()) {
    curCredit := curCredit + 1.U
  }

  // Output interface logic
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.enq.ready := curCredit =/= 0.U

  // Update internal credit register based on credit signal
  icredit := io.deq.credit
  
  // Assign current credit to output
  io.curCredit := curCredit
}
