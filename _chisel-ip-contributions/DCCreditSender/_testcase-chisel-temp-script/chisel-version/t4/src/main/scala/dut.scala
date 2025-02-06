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

  // Initialize the credit counter to maxCredit
  val creditCounter = RegInit(maxCredit.U(log2Ceil(maxCredit).W))
  
  // Holds the last credit signal value for determining actions
  val icredit = RegNext(io.deq.credit, init = false.B)
  
  // Logic to update the credit counter
  when (io.enq.fire && !io.deq.credit) { // Data is sent, decrement counter
    creditCounter := creditCounter - 1.U
  } .elsewhen (!io.enq.fire && io.deq.credit) { // Credit received, increment counter
    creditCounter := creditCounter + 1.U
  }

  // Ready to enqueue only if there's credit available
  io.enq.ready := creditCounter > 0.U

  // Registers to hold output data and valid flag
  val dataOut = RegEnable(io.enq.bits, io.enq.fire)
  val validOut = RegNext(io.enq.fire, init = false.B)

  // Output connections
  io.deq.bits := dataOut
  io.deq.valid := validOut
  io.curCredit := creditCounter
}

