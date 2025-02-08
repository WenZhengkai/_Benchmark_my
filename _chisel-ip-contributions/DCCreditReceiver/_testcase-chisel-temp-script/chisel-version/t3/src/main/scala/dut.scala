import chisel3._
import chisel3.util._

// Define the CreditIO interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the dut module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))  // Incoming enqueue interface
    val deq = Decoupled(data)              // Outgoing dequeue interface
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // FIFO count
  })

  // Internal FIFO queue
  val outFifo = Module(new Queue(data, maxCredit))

  // Internal registers
  val ivalid = RegNext(io.enq.valid)
  val idata = RegEnable(io.enq.bits, io.enq.valid)
  val ocredit = RegInit(false.B)

  // Wire for next credit logic
  val nextCredit = WireDefault(false.B)

  // FIFO control logic
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
    nextCredit := Mux(io.deq.ready, ivalid, false.B)
    outFifo.io.deq.ready := false.B
  }.otherwise {
    // FIFO mode
    io.deq <> outFifo.io.deq
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    nextCredit := outFifo.io.deq.fire
  }

  // Update ocredit and connect to input credit
  ocredit := nextCredit
  io.enq.credit := ocredit

  // Connect fifoCount to the current utilised FIFO space
  io.fifoCount := outFifo.io.count
}

