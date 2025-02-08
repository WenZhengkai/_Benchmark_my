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
  val ivalid = RegNext(io.enq.valid, false.B) // Delayed io.enq.valid
  val idata = RegNext(io.enq.bits)            // Delayed io.enq.bits
  val ocredit = RegNext(nextCredit, false.B)  // Delayed nextCredit

  // Register ocredit to io.enq.credit
  io.enq.credit := ocredit

  // Task 3: Instantiate and Connect FIFO Queue
  val outFifo = Module(new Queue(data, maxCredit))
  outFifo.io.enq.bits := idata
  outFifo.io.deq.ready := io.deq.ready

  // Task 4: Implement Bypass Logic
  val bypassActive = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  when(bypassActive && io.deq.ready) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    nextCredit := ivalid
  }.otherwise {
    // Task 5: Default Non-Bypass Operation
    outFifo.io.enq.valid := ivalid
    io.deq.valid := outFifo.io.deq.valid
    io.deq.bits := outFifo.io.deq.bits
    nextCredit := outFifo.io.deq.fire()
  }

  // Task 6: FIFO Count Visibility
  io.fifoCount := outFifo.io.count
}

