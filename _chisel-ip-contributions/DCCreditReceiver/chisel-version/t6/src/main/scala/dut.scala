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

  // FIFO queue instantiation
  val outFifo = Module(new Queue(data, maxCredit))

  // Internal registers
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegEnable(io.enq.bits, io.enq.valid)
  val ocredit = RegInit(false.B)

  // Default wire logic
  val nextCredit = WireInit(false.B)

  // Enqueue logic
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata

  // Bypass logic and dequeue interfacing
  io.deq.valid := Mux(!outFifo.io.deq.valid && outFifo.io.count === 0.U, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(!outFifo.io.deq.valid && outFifo.io.count === 0.U, idata, outFifo.io.deq.bits)
  outFifo.io.deq.ready := io.deq.ready && outFifo.io.deq.valid

  // Credit management
  nextCredit := Mux(!outFifo.io.deq.valid && outFifo.io.count === 0.U, io.deq.ready && ivalid, outFifo.io.deq.fire)
  when(io.deq.ready) {
    ocredit := nextCredit
  }
  io.enq.credit := ocredit

  // Fifo count tracking
  io.fifoCount := outFifo.io.count
}

