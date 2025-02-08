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

  // Internal FIFO queue for storing data
  val outFifo = Module(new Queue(data, maxCredit))

  // Registers to hold incoming data
  val ivalid = RegNext(io.enq.valid, false.B)
  val idata = RegNext(io.enq.bits)

  // Wire logic for bypass and credit generation
  val nextCredit = WireDefault(false.B)

  // Bypass condition - when the FIFO is empty
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  // Output logic based on bypass condition
  io.deq.valid := Mux(bypass, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(bypass, idata, outFifo.io.deq.bits)

  // Determine when to enqueue data into FIFO
  outFifo.io.enq.valid := Mux(bypass, false.B, ivalid)
  outFifo.io.enq.bits := idata

  // Handle dequeue readiness
  outFifo.io.deq.ready := io.deq.ready

  // Generate the next credit signal
  nextCredit := Mux(bypass, io.deq.fire, outFifo.io.deq.fire)
  io.enq.credit := nextCredit

  // Connect FIFO count to output
  io.fifoCount := outFifo.io.count
}

