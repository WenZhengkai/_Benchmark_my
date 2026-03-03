import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, s"'entries' must be > 0, got $entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ptrWidth = math.max(1, log2Ceil(entries))

  val ram = Mem(entries, gen)

  val enq_ptr    = RegInit(0.U(ptrWidth.W))
  val deq_ptr    = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  private def wrapInc(ptr: UInt): UInt = {
    if (entries == 1) 0.U
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  val ptr_match = enq_ptr === deq_ptr
  val empty     = ptr_match && !maybe_full
  val full      = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  val flush = if (hasFlush) io.flush else false.B
  val do_enq = io.enq.fire && !flush
  val do_deq = io.deq.fire && !flush

  when(flush) {
    enq_ptr    := 0.U
    deq_ptr    := 0.U
    maybe_full := false.B
  }.otherwise {
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
  }

  val count = Wire(UInt(log2Ceil(entries + 1).W))
  if (isPow2(entries)) {
    count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), enq_ptr - deq_ptr)
  } else {
    count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
    )
  }
  io.count := count
}
