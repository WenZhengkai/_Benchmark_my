import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO queue to manage incoming data
  val fifo = Module(new Queue(data, maxCredit))
  
  // Bypass logic
  val bypass = Wire(Bool())
  bypass := (fifo.io.count === 0.U) && io.deq.ready

  // Manage enqueue and dequeue
  fifo.io.enq.valid := io.enq.valid && !bypass
  fifo.io.enq.bits := io.enq.bits
  io.deq.valid := Mux(bypass, io.enq.valid, fifo.io.deq.valid)
  io.deq.bits := Mux(bypass, io.enq.bits, fifo.io.deq.bits)
  fifo.io.deq.ready := io.deq.ready && !bypass

  // Credit logic
  val nextCredit = Wire(Bool())
  nextCredit := io.deq.ready && (bypass || fifo.io.deq.valid)
  val creditReg = RegInit(false.B)
  
  when(nextCredit) {
    creditReg := true.B
  }.otherwise {
    creditReg := false.B
  }
  
  io.enq.credit := creditReg

  // FIFO count output
  io.fifoCount := fifo.io.count
}

