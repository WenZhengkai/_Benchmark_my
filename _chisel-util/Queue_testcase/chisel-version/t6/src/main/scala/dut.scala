import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ptrWidth = math.max(1, log2Ceil(entries))
  private val ram      = Mem(entries, gen)

  private val enq_ptr    = RegInit(0.U(ptrWidth.W))
  private val deq_ptr    = RegInit(0.U(ptrWidth.W))
  private val maybe_full = RegInit(false.B)

  private val ptr_match = enq_ptr === deq_ptr
  private val empty     = ptr_match && !maybe_full
  private val full      = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  private val do_enq = io.enq.valid && io.enq.ready
  private val do_deq = io.deq.valid && io.deq.ready

  private def wrapInc(ptr: UInt): UInt = {
    Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := wrapInc(enq_ptr)
  }

  when(do_deq) {
    deq_ptr := wrapInc(deq_ptr)
  }

  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  if (hasFlush) {
    when(io.flush) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  if (isPow2(entries)) {
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
  } else {
    val dist = Mux(
      enq_ptr >= deq_ptr,
      enq_ptr - deq_ptr,
      (entries.U + enq_ptr) - deq_ptr
    )
    io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), dist)
  }
}
