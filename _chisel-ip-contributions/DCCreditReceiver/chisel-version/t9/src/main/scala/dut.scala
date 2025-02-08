import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

class dut[D <: Data](data: D, val maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO
  val outFifo = Module(new Queue(data, maxCredit))

  // Registers for storing input state
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)

  // Register for delayed credit signal
  val ocredit = RegInit(false.B)

  // Wire Logic
  val nextCredit = WireDefault(false.B)

  // Bypass condition
  val bypassMode = !outFifo.io.deq.valid && (outFifo.io.count === 0.U)

  // FIFO Connections
  outFifo.io.enq.valid := Mux(io.deq.ready, false.B, ivalid)
  outFifo.io.enq.bits := idata
  io.deq <> outFifo.io.deq

  when(io.enq.valid) {
    ivalid := true.B
    idata := io.enq.bits
  }.elsewhen(io.deq.ready && bypassMode) {
    ivalid := false.B
  }

  when(bypassMode) {
    io.deq.valid := ivalid
    io.deq.bits := idata
    outFifo.io.enq.valid := ivalid && !io.deq.ready
    nextCredit := io.deq.ready && ivalid
  }.otherwise {
    nextCredit := outFifo.io.deq.fire
  }

  ocredit := nextCredit
  io.enq.credit := ocredit

  // FIFO Count
  io.fifoCount := outFifo.io.count
}

// Note: To use the above code, ensure you have the Chisel3 library properly configured.
// Also, the Queue class in Chisel3 handles simple FIFO operations, so no extra definition is required for it.
