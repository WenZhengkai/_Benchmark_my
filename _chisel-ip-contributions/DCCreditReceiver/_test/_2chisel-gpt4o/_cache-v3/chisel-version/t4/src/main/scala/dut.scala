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

  // FIFO queue instantiation
  val outFifo = Module(new Queue(data, maxCredit))

  // Registers
  val ivalid = RegNext(io.enq.valid)
  val idata = RegNext(io.enq.bits)
  val ocredit = RegInit(false.B)

  // Wire Logic
  val nextCredit = WireDefault(false.B)

  // Bypass logic
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  io.deq.valid := Mux(bypass, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(bypass, idata, outFifo.io.deq.bits)

  outFifo.io.enq.bits := idata
  outFifo.io.enq.valid := Mux(bypass && io.deq.ready, false.B, ivalid)

  outFifo.io.deq.ready := io.deq.ready && !bypass
  nextCredit := Mux(bypass, ivalid && io.deq.ready, outFifo.io.deq.fire)

  ocredit := nextCredit
  io.enq.credit := ocredit
  io.fifoCount := outFifo.io.count
}

