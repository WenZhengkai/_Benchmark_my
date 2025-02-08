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
    val deq = DecoupledIO(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal registers
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegNext(next = false.B, init = false.B)

  // FIFO queue instantiation
  val outFifo = Module(new Queue(data, maxCredit))
  outFifo.io.enq.valid := ivalid && !io.deq.ready
  outFifo.io.enq.bits := idata
  outFifo.io.deq.ready := io.deq.ready

  // FIFO count visibility
  io.fifoCount := outFifo.io.count

  // Bypass mode
  val bypass = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  // Update internal registers
  when(io.enq.valid && io.enq.credit) {
    ivalid := true.B
    idata := io.enq.bits
  }

  // Handle output to deq interface
  io.deq.valid := Mux(bypass, ivalid, outFifo.io.deq.valid)
  io.deq.bits := Mux(bypass, idata, outFifo.io.deq.bits)

  // Determine if next credit should be issued
  val nextCredit = WireInit(false.B)
  nextCredit := Mux(bypass && io.deq.ready, ivalid, outFifo.io.deq.fire)

  // Output credit back to the enqueuing interface
  io.enq.credit := ocredit
  ocredit := nextCredit
}

