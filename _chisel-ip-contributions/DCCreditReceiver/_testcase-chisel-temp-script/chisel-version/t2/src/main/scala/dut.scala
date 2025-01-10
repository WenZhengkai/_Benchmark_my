import chisel3._
import chisel3.util._

// Definition of CreditIO
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}

// Definition of DCCreditReceiver module
class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))    // Credit-based enqueue interface
    val deq = DecoupledIO(data)              // Decoupled dequeue interface
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W)) // FIFO entry count
  })

  // Internal FIFO Queue
  val fifo = Module(new Queue(data, maxCredit))

  // Wires to track bypass and internal FIFO logic
  val bypassValid = Wire(Bool())
  val bypassReady = Wire(Bool())
  val bypassFired = Wire(Bool())

  // Bypass logic condition
  bypassValid := io.enq.valid && fifo.io.count === 0.U // Enqueue valid & FIFO empty
  bypassReady := io.deq.ready                          // Consumer is ready
  bypassFired := bypassValid && bypassReady            // Bypass handshake

  // Managing fifo enqueue/dequeue
  fifo.io.enq.valid := io.enq.valid && !bypassValid    // Enqueue to FIFO when not bypass
  fifo.io.enq.bits := io.enq.bits                     // Pass input data to FIFO
  fifo.io.deq.ready := io.deq.ready && !bypassValid   // Dequeue FIFO when not in bypass mode

  // Output data from bypass or FIFO
  io.deq.valid := bypassValid || fifo.io.deq.valid    // Valid when bypass or FIFO ready
  io.deq.bits := Mux(bypassValid, io.enq.bits, fifo.io.deq.bits) // Choose data from bypass or FIFO

  // Send credit back to sender
  io.enq.credit := bypassFired || fifo.io.deq.fire    // Credit on bypass success or FIFO dequeue

  // Output FIFO count
  io.fifoCount := fifo.io.count                       // Expose FIFO entry count
}


