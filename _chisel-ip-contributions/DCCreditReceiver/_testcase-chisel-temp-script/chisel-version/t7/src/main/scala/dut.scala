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

  // Internal registers to store the delayed input signals
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegInit(false.B)

  // Update registers with incoming data
  when(io.enq.valid && io.enq.credit) {
    ivalid := true.B
    idata := io.enq.bits
  }.otherwise {
    ivalid := false.B
  }

  // Create a FIFO queue with the specified maximum credit (depth)
  val outFifo = Module(new Queue(data, maxCredit))

  // Connect enqueue signals to the Queue
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata

  // Bypass logic and credit generation
  val nextCredit = WireDefault(false.B)

  // Dequeue logic
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) { // FIFO empty and bypass mode
    io.deq.valid := ivalid
    io.deq.bits := idata
    nextCredit := Mux(io.deq.ready, ivalid, false.B)
  }.otherwise {
    io.deq <> outFifo.io.deq
    nextCredit := outFifo.io.deq.fire
  }
  
  // Credit logic
  ocredit := nextCredit
  io.enq.credit := ocredit
  
  // FIFO count
  io.fifoCount := outFifo.io.count
}

