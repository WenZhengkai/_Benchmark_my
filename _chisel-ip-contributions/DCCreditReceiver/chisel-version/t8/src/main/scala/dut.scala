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
  val idata = RegEnable(io.enq.bits, io.enq.valid)

  // Wire logic
  val nextCredit = Wire(Bool())

  // FIFO logic - Bypass + Queue management
  when(!outFifo.io.deq.valid && outFifo.io.count === 0.U) { // Bypass mode condition
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
    nextCredit := Mux(io.deq.ready, ivalid, false.B)
    outFifo.io.deq.ready := false.B
  } .otherwise { // Normal operation, when FIFO is being used
    io.deq <> outFifo.io.deq
    outFifo.io.enq.valid := io.enq.valid
    outFifo.io.enq.bits := io.enq.bits
    nextCredit := outFifo.io.deq.fire
  }

  // Updating credit signal
  val ocredit = RegNext(nextCredit, init = false.B)
  io.enq.credit := ocredit

  // Exposing FIFO count
  io.fifoCount := outFifo.io.count
}

