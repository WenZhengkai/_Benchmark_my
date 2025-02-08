import chisel3._
import chisel3.util._

// Define the CreditIO Interface
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Define the dut Module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data)) // Incoming credit-based interface
    val deq = Decoupled(data)             // Outgoing decoupled interface
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // FIFO count
  })

  // Internal FIFO queue
  val outFifo = Module(new Queue(data, maxCredit))

  // Internal Registers
  val ivalid = RegNext(io.enq.valid)
  val idata = RegNext(Mux(io.enq.valid, io.enq.bits, 0.U.asTypeOf(data)))
  val ocredit = RegInit(false.B)

  // Bypass Logic
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)
  io.deq.valid := Mux(bypass, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(bypass, idata, outFifo.io.deq.bits)
  outFifo.io.deq.ready := io.deq.ready && !bypass

  // Setup enqueue conditions based on bypass logic
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata
  io.enq.credit := Mux(bypass, Mux(io.deq.ready, ivalid, false.B), outFifo.io.deq.fire)

  // FIFO count output
  io.fifoCount := outFifo.io.count
}

