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

  // Initialize Registers
  val icredit = RegInit(false.B)
  val curCredit = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  val validOut = RegInit(false.B)
  val dataOut = Reg(data.cloneType)

  // Task 1: Implement Credit Register (`icredit`)
  // Update icredit based on the input credit signal each cycle
  icredit := io.deq.credit

  // Task 2: Implement Credit Counter (`curCredit`)
  when(icredit && !io.enq.fire()) {
    // Increment curCredit when credit is available but no new data is enqueued
    curCredit := Mux(curCredit < maxCredit.U, curCredit + 1.U, curCredit)
  }.elsewhen(io.enq.fire() && !icredit) {
    // Decrement curCredit when data is enqueued but no credit is available
    curCredit := Mux(curCredit > 0.U, curCredit - 1.U, curCredit)
  }

  // Ensure curCredit cannot exceed maxCredit or fall below zero
  io.curCredit := curCredit

  // Task 3: Define Ready Signal (`io.enq.ready`)
  // Create signal to indicate readiness to accept new data on enqueue interface
  io.enq.ready := curCredit > 0.U

  // Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
  // Latch incoming data into dataOut when data is enqueued
  when(io.enq.fire()) {
    dataOut := io.enq.bits
  }
  validOut := RegNext(io.enq.fire(), init = false.B)

  // Task 5: Connect Output Interface (`deq`) to Internal Logic
  io.deq.valid := validOut
  io.deq.bits := dataOut

}

