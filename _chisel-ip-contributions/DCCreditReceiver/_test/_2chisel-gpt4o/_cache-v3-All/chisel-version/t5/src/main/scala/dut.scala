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
  val nextCredit = WireInit(false.B)

  // Task 2: Implement Register Logic
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegInit(false.B)

  ivalid := io.enq.valid
  idata := io.enq.bits
  ocredit := nextCredit

  // Task 3: Instantiate and Connect FIFO Queue
  val outFifo = Module(new Queue(data, maxCredit))
  io.enq.credit := ocredit
  outFifo.io.enq.bits := idata

  // Task 4 and 5: Implement Bypass Logic and Default Non-Bypass Operation
  when (!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B
    nextCredit := io.deq.ready && ivalid
  } .otherwise {
    // FIFO handling
    io.deq <> outFifo.io.deq
    outFifo.io.enq.valid := ivalid
    nextCredit := outFifo.io.deq.fire
  }

  // Task 6: FIFO Count Visibility
  io.fifoCount := outFifo.io.count
}

// Example instantiation
// val myReceiver = Module(new dut(UInt(32.W), 16))
// myReceiver.io.enq.valid := ...
// myReceiver.io.enq.bits := ...
// myReceiver.io.deq.ready := ...
