import chisel3._
import chisel3.util._

// Credit-based flow control interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// DCCreditReceiver module definition
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Registers for delayed input signals
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegInit(false.B)

  // Internal FIFO Queue
  val outFifo = Module(new Queue(data.cloneType, maxCredit))

  // Bypass Logic and Register Updates
  val fifoEmpty = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  when(io.enq.valid) {
    ivalid := io.enq.valid
    idata := io.enq.bits
  }

  io.deq.valid := Mux(fifoEmpty, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(fifoEmpty, idata, outFifo.io.deq.bits)
  outFifo.io.deq.ready := !fifoEmpty && io.deq.ready

  // FIFO Enqueue Logic
  outFifo.io.enq.valid := Mux(fifoEmpty && io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata
  
  val nextCredit = WireDefault(false.B)
  nextCredit := Mux(fifoEmpty, ivalid && io.deq.ready, outFifo.io.deq.fire)

  io.enq.credit := ocredit
  ocredit := nextCredit

  // FIFO Count Output
  io.fifoCount := outFifo.io.count
}

