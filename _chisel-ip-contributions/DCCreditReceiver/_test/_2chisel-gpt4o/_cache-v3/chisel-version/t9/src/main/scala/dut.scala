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

  // Registers for the bypass logic
  val ivalid = RegNext(io.enq.valid)
  val idata = RegNext(io.enq.bits)

  // Wire for credit signal management
  val nextCredit = WireDefault(false.B)
  val ocredit = RegNext(nextCredit) // Delayed credit signal

  // Processing logic
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode when FIFO is empty
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
    // Normal operation mode with FIFO
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }

  // Connect the credit signal
  io.enq.credit := ocredit

  // FIFO count
  io.fifoCount := outFifo.io.count
}


