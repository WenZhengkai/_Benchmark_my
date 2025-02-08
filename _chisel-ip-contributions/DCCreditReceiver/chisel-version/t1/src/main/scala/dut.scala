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
  
  // Internal FIFO queue
  val outFifo = Module(new Queue(data, maxCredit))
  
  // Registers to store delayed input signals
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegNext(io.enq.bits)

  // Wire for generating the next credit signal
  val nextCredit = WireDefault(0.B)

  // Connect outputs
  io.deq.bits := Mux(!outFifo.io.deq.valid && outFifo.io.count === 0.U, idata, outFifo.io.deq.bits)
  io.deq.valid := Mux(!outFifo.io.deq.valid && outFifo.io.count === 0.U, ivalid, outFifo.io.deq.valid)
  io.fifoCount := outFifo.io.count

  // FIFO enqueue logic
  outFifo.io.enq.bits := idata
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)

  // FIFO dequeue logic
  outFifo.io.deq.ready := io.deq.ready

  // Credit management
  nextCredit := Mux(io.deq.ready, ivalid, outFifo.io.deq.fire)
  val ocredit = RegNext(nextCredit, init = false.B)
  io.enq.credit := ocredit
}


