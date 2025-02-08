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

  // Queue instantiation
  val outFifo = Module(new Queue(data, maxCredit))

  // Registers for delayed signals
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegInit(false.B)

  // Default wire values
  val nextCredit = WireDefault(false.B)

  // Latch input data and validity
  ivalid := io.enq.valid
  idata := io.enq.bits

  // Bypass logic
  when (!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B
    nextCredit := io.deq.ready && ivalid
  } .otherwise {
    io.deq.valid := outFifo.io.deq.valid
    io.deq.bits := outFifo.io.deq.bits
    outFifo.io.enq.valid := ivalid
    outFifo.io.deq.ready := io.deq.ready
    nextCredit := outFifo.io.deq.fire
  }

  // Enqueue data into the FIFO
  outFifo.io.enq.bits := idata
  outFifo.io.enq.ready := !outFifo.io.deq.valid || outFifo.io.deq.ready

  // Update credit output
  ocredit := nextCredit
  io.enq.credit := ocredit

  // Expose FIFO count
  io.fifoCount := outFifo.io.count
}

