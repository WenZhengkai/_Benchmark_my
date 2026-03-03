import chisel3._
import chisel3.util.{QueueIO, isPow2, log2Ceil}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ram = Mem(entries, gen)

  private val ptrWidth = math.max(1, log2Ceil(entries))
  private val enq_ptr = RegInit(0.U(ptrWidth.W))
  private val deq_ptr = RegInit(0.U(ptrWidth.W))
  private val maybe_full = RegInit(false.B)

  private def ptrInc(ptr: UInt): UInt = {
    if (isPow2(entries)) {
      (ptr + 1.U)(ptrWidth - 1, 0)
    } else {
      Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
    }
  }

  private val ptr_match = enq_ptr === deq_ptr
  private val empty = ptr_match && !maybe_full
  private val full = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)

  private val flush = if (hasFlush) io.flush else false.B
  private val do_enq = io.enq.valid && io.enq.ready && !flush
  private val do_deq = io.deq.valid && io.deq.ready && !flush

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := ptrInc(enq_ptr)
  }

  when(do_deq) {
    deq_ptr := ptrInc(deq_ptr)
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

  private val ptr_diff = enq_ptr - deq_ptr
  if (isPow2(entries)) {
    io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
  } else {
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr > enq_ptr, entries.U +& ptr_diff, ptr_diff)
    )
  }
}
