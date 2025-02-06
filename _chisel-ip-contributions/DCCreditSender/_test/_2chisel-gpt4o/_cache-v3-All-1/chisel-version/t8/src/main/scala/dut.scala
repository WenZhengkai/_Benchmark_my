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
    val curCredit = Output(UInt(log2Ceil(maxCredit + 1).W))
  })
  
  // Task 1: Implement Credit Register (`icredit`)
  val icredit = RegInit(false.B)
  icredit := io.deq.credit
  
  // Task 2: Implement Credit Counter (`curCredit`)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit + 1).W))
  
  when (icredit && !io.enq.fire) {
    // Increment credit when credit is available and enq is not fired
    curCredit := Mux(curCredit =/= maxCredit.U, curCredit + 1.U, curCredit)
  } .elsewhen (!icredit && io.enq.fire) {
    // Decrement credit when enq is fired and icredit is not available
    curCredit := Mux(curCredit =/= 0.U, curCredit - 1.U, curCredit)
  }

  // Task 3: Define Ready Signal (`io.enq.ready`)
  io.enq.ready := curCredit > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Connect the current credit count to the `curCredit` output
  io.curCredit := curCredit
}

