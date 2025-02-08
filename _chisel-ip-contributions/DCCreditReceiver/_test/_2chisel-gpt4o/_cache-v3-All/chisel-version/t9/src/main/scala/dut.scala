import chisel3._
import chisel3.util._

// Definition for CreditIO interface used for the enqueue side
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Main dut module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Task 1: Define Wire Logic
  val nextCredit = WireDefault(false.B)

  // Task 2: Implement Register Logic
  val ivalid = RegNext(io.enq.valid, init = false.B)
  val idata  = RegNext(io.enq.bits)
  val ocredit = RegNext(nextCredit, init = false.B)

  io.enq.credit := ocredit

  // Task 3: Instantiate and Connect FIFO Queue
  val outFifo = Module(new Queue(data, maxCredit))
  outFifo.io.enq.bits := io.enq.bits

  // Task 4 & 5: Implement Bypass Logic and Default Non-Bypass Operation
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode
    io.deq.valid := ivalid
    io.deq.bits  := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B
    nextCredit := ivalid && io.deq.ready
  }.otherwise {
    // Normal operation
    io.deq <> outFifo.io.deq
    outFifo.io.enq.valid := ivalid
    nextCredit := outFifo.io.deq.fire
  }

  // Task 6: FIFO Count Visibility
  io.fifoCount := outFifo.io.count
}

// Usage Example (not included in the module definition)
// object dutDriver extends App {
//   chisel3.Driver.execute(args, () => new dut(UInt(8.W), 16))
// }
