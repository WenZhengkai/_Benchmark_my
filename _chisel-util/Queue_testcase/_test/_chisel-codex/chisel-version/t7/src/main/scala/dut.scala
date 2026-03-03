import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full  = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr.value)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  when(do_enq) {
    ram(enq_ptr.value) := io.enq.bits
    enq_ptr.inc()
  }

  when(do_deq) {
    deq_ptr.inc()
  }

  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr.reset()
      deq_ptr.reset()
      maybe_full := false.B
    }
  }

  val ptr_diff = enq_ptr.value - deq_ptr.value
  if (isPow2(entries)) {
    io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
  } else {
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr.value > enq_ptr.value, entries.U + ptr_diff, ptr_diff)
    )
  }
}
