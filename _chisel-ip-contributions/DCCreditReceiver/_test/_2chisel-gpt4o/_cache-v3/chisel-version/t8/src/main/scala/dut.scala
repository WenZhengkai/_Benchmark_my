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
    val deq = DecoupledIO(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO queue
  val outFifo = Module(new Queue(data, maxCredit))

  // Registers for storing delayed input valid and bits
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegEnable(io.enq.bits, io.enq.valid)

  // Bypass logic when FIFO is empty
  val bypass = Wire(Bool())
  bypass := !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  // Logic for nextCredit signal 
  val nextCredit = WireDefault(false.B)

  // Logic for FIFO and io.deq
  when(bypass) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B

    when(io.deq.ready && ivalid) {
      nextCredit := true.B
    }
  } .otherwise {
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }

  // Delayed credit signal
  val ocredit = RegNext(nextCredit, init = false.B)
  io.enq.credit := ocredit

  // FIFO Count
  io.fifoCount := outFifo.io.count
}

