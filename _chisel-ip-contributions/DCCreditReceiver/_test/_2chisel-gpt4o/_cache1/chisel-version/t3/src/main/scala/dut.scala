import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid  = Output(Bool())
  val credit = Input(Bool())
  val bits   = Output(data.cloneType)
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  val io = IO(new Bundle {
    val enq      = Flipped(new CreditIO(data))
    val deq      = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO Queue
  val fifo = Module(new Queue(data, maxCredit))
  
  // Enqueue to FIFO if valid and not bypassing
  fifo.io.enq.valid := io.enq.valid && !io.deq.ready
  fifo.io.enq.bits := io.enq.bits

  // Bypass logic
  when (fifo.io.empty && io.enq.valid && io.deq.ready) {
    // Bypass the FIFO
    io.deq.valid := io.enq.valid
    io.deq.bits := io.enq.bits
  } .otherwise {
    // Use FIFO
    fifo.io.deq.ready := io.deq.ready
    io.deq.valid := fifo.io.deq.valid
    io.deq.bits := fifo.io.deq.bits
  }
  
  // Credit management
  io.enq.credit := (if (fifo.io.empty) io.deq.ready else fifo.io.deq.fire)

  // FIFO count for debug/monitoring
  io.fifoCount := fifo.io.count

  // Synchronization logic (registers to hold incoming data)
  val ivalid = RegNext(io.enq.valid && !io.deq.ready) // Register to hold valid signal if bypassing
  val idata  = RegEnable(io.enq.bits, io.enq.valid && !io.deq.ready) // Register to hold data bits
  val ocredit = RegNext(io.enq.credit) // Register for delayed credit

  // Wire Logic for nextCredit
  val nextCredit = Wire(Bool())
  nextCredit := Mux(io.deq.ready && fifo.io.empty, io.enq.valid, fifo.io.deq.fire)

  // Connecting wire logic to output
  io.enq.credit := nextCredit

}

