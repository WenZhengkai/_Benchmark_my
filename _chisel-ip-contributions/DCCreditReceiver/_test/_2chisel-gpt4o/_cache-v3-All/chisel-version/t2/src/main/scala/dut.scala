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

  // Instantiate the FIFO queue with a depth of maxCredit
  val outFifo = Module(new Queue(data, maxCredit))

  // Task 1: Define Wire Logic
  val nextCredit = WireInit(false.B)

  // Task 2: Implement Register Logic
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata = RegEnable(io.enq.bits, io.enq.valid)

  // Credit register logic
  val ocredit = Reg(nextCredit)

  // Task 3: Connect FIFO Queue
  outFifo.io.enq.bits := idata
  outFifo.io.enq.valid := false.B
  io.deq.bits := idata
  io.deq.valid := false.B

  // Task 4: Implement Bypass Logic
  when (!outFifo.io.deq.valid && outFifo.io.count === 0.U) {
    when (io.deq.ready) {
      io.deq.valid := ivalid
      outFifo.io.enq.valid := false.B
      nextCredit := ivalid
    }
  }

  // Task 5: Default Non-Bypass Operation
  when (outFifo.io.deq.valid || (outFifo.io.count =/= 0.U)) {
    outFifo.io.enq.valid := ivalid
    io.deq.valid := outFifo.io.deq.valid
    io.deq.bits := outFifo.io.deq.bits
    outFifo.io.deq.ready := io.deq.ready
    nextCredit := outFifo.io.deq.fire
  }

  // Connect credit to input interface
  io.enq.credit := ocredit

  // Task 6: FIFO Count Visibility
  io.fifoCount := outFifo.io.count
}

