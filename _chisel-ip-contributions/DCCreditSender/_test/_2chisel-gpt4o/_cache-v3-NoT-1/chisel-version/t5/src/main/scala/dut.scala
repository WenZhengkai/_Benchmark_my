import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](dataType: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit must be greater than or equal to 1")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = new CreditIO(dataType)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })
  
  // Task 1: Implement Credit Register (`icredit`)
  val icredit = RegInit(false.B)
  icredit := io.deq.credit
  
  // Task 2: Implement Credit Counter (`curCredit`)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  when(icredit && !io.enq.fire) {
    curCredit := Mux(curCredit < maxCredit.U, curCredit + 1.U, curCredit)
  } .elsewhen(io.enq.fire && !icredit) {
    curCredit := Mux(curCredit > 0.U, curCredit - 1.U, curCredit)
  }
  
  // Ensure `curCredit` does not exceed its bounds
  when(curCredit > maxCredit.U) { curCredit := maxCredit.U }
  when(curCredit < 0.U) { curCredit := 0.U }

  // Task 3: Define Ready Signal (`io.enq.ready`)
  io.enq.ready := curCredit > 0.U
  
  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, false.B)
  
  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut
  io.deq.credit := io.deq.credit
  
  // Connect `curCredit` output for monitoring
  io.curCredit := curCredit
}


