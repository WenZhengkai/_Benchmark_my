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

  // Internal signals and registers
  val nextCredit = WireDefault(false.B)
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)
  val ocredit = RegInit(false.B)

  // Instantiate FIFO Queue with maxCredit depth
  val outFifo = Module(new Queue(data, maxCredit))

  // Assignments for tracking count
  io.fifoCount := outFifo.io.count

  // Delay input valid and data signals
  when(io.enq.valid) {
    ivalid := true.B
    idata := io.enq.bits
  }.otherwise {
    ivalid := false.B
  }

  // FIFO bypass when empty, direct enqueue-dequeue pass
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U)) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := false.B
    outFifo.io.deq.ready := false.B
  }.otherwise {
    io.deq <> outFifo.io.deq
    outFifo.io.enq.valid := ivalid
    outFifo.io.enq.bits := idata
  }

  // Credit management, update credits for an empty FIFO or successful dequeue
  when(!outFifo.io.deq.valid && (outFifo.io.count === 0.U) && io.deq.ready) {
    nextCredit := ivalid
  } .otherwise {
    nextCredit := outFifo.io.deq.fire()
  }

  // Assign outputs and update registers
  io.enq.credit := ocredit
  ocredit := nextCredit
}


