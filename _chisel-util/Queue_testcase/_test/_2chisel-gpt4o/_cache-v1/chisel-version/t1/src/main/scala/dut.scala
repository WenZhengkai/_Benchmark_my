import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)

  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  val ptr_match = enq_ptr === deq_ptr
  val maybe_full = RegInit(false.B)

  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue operation
  val do_enq = io.enq.valid && !full
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }

  // Dequeue operation
  val do_deq = io.deq.ready && !empty
  when (do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  // Update maybe_full flag
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Flush mechanism
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Connect IOs
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)

  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(maybe_full, entries.U, 0.U) + ptr_diff
}

// Example usage
// val queue = Module(new dut(UInt(8.W), 8, hasFlush = true))
