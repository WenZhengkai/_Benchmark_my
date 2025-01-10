package dccreditreceiver

import chisel3._
import chisel3.util._

class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)

  override def cloneType: this.type = new CreditIO(data).asInstanceOf[this.type]
}

class dut[D <: Data](data: D, maxCredit: Int) extends Module {
  require(maxCredit > 0, "maxCredit must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(new CreditIO(data))
    val deq = Decoupled(data)
    val fifoCount = Output(UInt(log2Ceil(maxCredit + 1).W))
  })

  // Internal FIFO queue
  val fifo = Module(new Queue(data, maxCredit))
  val fifoCount = fifo.io.count

  // Bypass logic wires
  val bypass = Wire(Bool()) // Determines whether bypass mode is active
  val bypassValid = Wire(Bool())
  val bypassBits = Wire(data)

  // FIFO enqueue and dequeue connections
  fifo.io.enq.valid := io.enq.valid && !bypass
  fifo.io.enq.bits := io.enq.bits
  fifo.io.deq.ready := io.deq.ready

  // Bypass conditions
  bypass := (fifoCount === 0.U && io.enq.valid && io.deq.ready)
  bypassValid := io.enq.valid && bypass
  bypassBits := io.enq.bits

  // Dequeue logic
  io.deq.valid := fifo.io.deq.valid || bypassValid
  io.deq.bits := Mux(bypass, bypassBits, fifo.io.deq.bits)

  // Credit issuance logic
  val creditIssued = Wire(Bool())
  creditIssued := Mux(bypass, io.deq.fire, fifo.io.deq.fire)

  io.enq.credit := creditIssued

  // FIFO counter output
  io.fifoCount := fifoCount
}

