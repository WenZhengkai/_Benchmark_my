package credit
import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit >= 1, "maxCredit should be greater than or equal to 1")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = new CreditIO(data)
    val curCredit = Output(UInt(log2Ceil(maxCredit).W))
  })

  // Internal credit register for receiving credit signal
  val icredit = RegNext(io.deq.credit, init = false.B)
  // Current credit counter initialized to maxCredit
  val curCreditReg = RegInit(maxCredit.U(log2Ceil(maxCredit).W))

  // Temporary registers for data and validity meant for dequeueing
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Handle credit count increments and decrements
  when(icredit && !io.enq.fire) { // Only increase credit if credit signal is high and no enqueue fire
    curCreditReg := curCreditReg + 1.U
  }.elsewhen(!icredit && io.enq.fire) { // Decrease credit if enqueue fires and no credit signal
    curCreditReg := curCreditReg - 1.U
  }

  // Set outputs for the dequeue interface
  io.deq.valid := validOut
  io.deq.bits := dataOut

  // Output current credit status
  io.curCredit := curCreditReg

  // Ready signal based on the current credit availability
  io.enq.ready := curCreditReg > 0.U

  // Indicate when to transmit data by sending a credit signal when validOut is high
  when(validOut) {
    // Logic for when to process credits or send data might go here
  }
}
