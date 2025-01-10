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

  // FIFO Instantiation with a depth of maxCredit
  val fifo = Module(new Queue(data, maxCredit))

  // Registers for input synchronization
  val ivalid = RegInit(false.B)
  val idata = Reg(data.cloneType)

  when(io.enq.valid) {
    ivalid := true.B
    idata := io.enq.bits
  }.otherwise {
    ivalid := false.B
  }

  // Wire to determine if FIFO is in bypass mode
  val bypass = WireDefault(false.B)

  // Bypass logic:
  // If the FIFO is empty and the consumer is ready, bypass the FIFO
  bypass := fifo.io.count === 0.U && io.deq.ready

  // Dequeue logic
  when(bypass) {
    io.deq.valid := io.enq.valid
    io.deq.bits := io.enq.bits
  }.otherwise {
    // Enqueue to FIFO
    fifo.io.enq.valid := io.enq.valid
    fifo.io.enq.bits := io.enq.bits

    // Connect FIFO to dequeue side
    io.deq <> fifo.io.deq
  }

  // Credit mechanism
  val nextCredit = WireDefault(io.deq.fire)
  io.enq.credit := Mux(bypass, io.deq.ready && io.deq.valid, fifo.io.deq.fire)

  // Expose the FIFO count
  io.fifoCount := fifo.io.count
}

