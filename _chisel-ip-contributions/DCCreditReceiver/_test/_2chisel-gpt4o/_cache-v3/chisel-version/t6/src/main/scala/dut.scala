import chisel3._
import chisel3.util._

// Define the CreditIO for the credit-based input interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main module definition
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal logic
  val outFifo = Module(new Queue(data, maxCredit))
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegNext(io.enq.bits)
  val ocredit = RegNext(false.B)
  io.enq.credit := ocredit

  // Bypass logic
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  // Wire logic for next credit
  val nextCredit = WireDefault(false.B)
  when(bypass) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.deq.ready := false.B

    when(io.deq.ready) {
      outFifo.io.enq.valid := false.B
      nextCredit := ivalid
    }.otherwise {
      outFifo.io.enq.valid := ivalid
    }
  } .otherwise {
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire()
  }
  
  ocredit := nextCredit
  outFifo.io.enq.bits := idata

  // FIFO Count
  io.fifoCount := outFifo.io.count
}


