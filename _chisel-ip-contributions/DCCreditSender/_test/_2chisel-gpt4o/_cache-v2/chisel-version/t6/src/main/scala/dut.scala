import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Initialize the credit register and counter
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))

  // Forward the current credit count to the output port
  io.curCredit := curCredit

  // Maintain data and valid registers
  val dataOut = RegEnable(io.enq.bits, io.enq.valid && io.enq.ready)
  val validOut = RegNext(io.enq.valid && io.enq.ready, false.B)

  // Handle the internal credit register
  icredit := icredit || io.deq.credit

  // Decrement or increment the credit counter based on conditions
  when (io.enq.valid && io.enq.ready && !icredit) {
    curCredit := curCredit - 1.U
  } .elsewhen (!io.enq.valid && icredit) {
    curCredit := curCredit + 1.U
  }

  // Ready signal logic
  io.enq.ready := curCredit > 0.U

  // Assign data to the deq interface
  io.deq.bits := dataOut
  io.deq.valid := validOut
  
  // Reset credit logic for next transactions
  when (validOut && !io.deq.credit) {
    icredit := false.B
  }
}

