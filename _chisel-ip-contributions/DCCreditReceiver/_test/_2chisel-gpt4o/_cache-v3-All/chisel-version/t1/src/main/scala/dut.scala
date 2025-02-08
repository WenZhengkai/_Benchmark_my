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

  // Task 1: Define Wire Logic
  val nextCredit = WireDefault(false.B)

  // Task 2: Implement Register Logic
  val ivalid = RegInit(false.B)
  val idata = Reg(data)
  val ocredit = RegInit(false.B)

  ivalid := io.enq.valid
  idata := io.enq.bits
  ocredit := nextCredit

  io.enq.credit := ocredit

  // Task 3: Instantiate and Connect FIFO Queue
  val outFifo = Module(new Queue(data, maxCredit))
  outFifo.io.enq.bits := idata
  outFifo.io.deq.ready := io.deq.ready

  // Task 4: Implement Bypass Logic
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    nextCredit := io.deq.ready && ivalid
  } .otherwise {
    // Task 5: Default Non-Bypass Operation
    outFifo.io.enq.valid := ivalid
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }

  // Task 6: FIFO Count Visibility
  io.fifoCount := outFifo.io.count
}

