import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val flush = if (hasFlush) Some(Input(Bool())) else None
  val count = Output(UInt(log2Ceil(entries + 1).W))
}

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Memory for Storage
  val ram = Mem(entries, gen)

  // Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue/Dequeue Logic
  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }

  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Flush Mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Output Logic
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  
  // Count Calculation
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)

  // Ensure the enq and deq end up being used as Decoupled interfaces
  when(!io.enq.ready) {
    io.enq.valid := false.B
  }

  when(!io.deq.valid) {
    io.deq.ready := false.B
  }
}

// This module can be instantiated as follows:
// val queue = Module(new dut(UInt(8.W), 16, true))
