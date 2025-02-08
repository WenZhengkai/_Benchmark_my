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

  // Modules: FIFO with given maxCredit depth
  val outFifo = Module(new Queue(data.cloneType, maxCredit))

  // Registers: To store the delayed input signals
  val ivalid = RegNext(io.enq.valid)
  val idata = RegNext(io.enq.bits)
  val ocredit = RegInit(false.B)
  
  // Wire for credit logic
  val nextCredit = WireDefault(false.B)

  // Functional flow control
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode when FIFO is empty
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B
    nextCredit := ivalid && io.deq.ready
  }.otherwise {
    // Normal FIFO operation
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }

  // Credit and FIFO Count update
  ocredit := nextCredit
  io.enq.credit := ocredit
  io.fifoCount := outFifo.io.count
}

