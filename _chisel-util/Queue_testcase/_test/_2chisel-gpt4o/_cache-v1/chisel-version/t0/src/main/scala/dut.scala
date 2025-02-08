import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Memory for Storage
  val ram = Mem(entries, gen)

  // Pointers and maybe_full flag
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer matching
  val ptr_match = enq_ptr === deq_ptr

  // Full and Empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue and Dequeue logic
  val do_enq = io.enq.valid && !full
  val do_deq = io.deq.ready && !empty

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

  // Flush logic
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Output logic
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)

  // Count calculation
  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), 
               Mux(deq_ptr > enq_ptr, entries.U + enq_ptr - deq_ptr, enq_ptr - deq_ptr))
}
