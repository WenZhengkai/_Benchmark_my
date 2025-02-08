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

  // Internal registers
  val ivalid = RegNext(io.enq.valid)
  val idata = RegNext(io.enq.bits)
  val ocredit = RegInit(false.B)

  // FIFO instantiation
  val outFifo = Module(new Queue(data, maxCredit))

  // Wire Logic
  val nextCredit = WireInit(false.B)

  // Bypass logic
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    // Bypass mode: directly connect input to output
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
    nextCredit := Mux(io.deq.ready, ivalid, false.B)
    outFifo.io.deq.ready := false.B
  } .otherwise {
    // Normal FIFO operation
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }

  // Update credit signal
  ocredit := nextCredit
  io.enq.credit := ocredit

  // FIFO count
  io.fifoCount := outFifo.io.count
}

// To instantiate this module, you would write:
// val receiver = Module(new dut(UInt(8.W), 16))
