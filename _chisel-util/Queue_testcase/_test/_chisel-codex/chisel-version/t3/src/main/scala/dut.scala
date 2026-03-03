import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)

  private val ptrWidth = math.max(1, log2Ceil(entries))
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  private def ptrInc(ptr: UInt): UInt = {
    if (entries == 1) 0.U
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  val ptr_match = enq_ptr === deq_ptr
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)

  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.valid && io.deq.ready

  val do_flush = if (hasFlush) io.flush else false.B

  when(do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }.otherwise {
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
  }

  val ptr_diff = enq_ptr - deq_ptr
  val countVal =
    if (isPow2(entries)) {
      Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
    } else {
      Mux(
        ptr_match,
        Mux(maybe_full, entries.U, 0.U),
        Mux(deq_ptr > enq_ptr, entries.U + ptr_diff, ptr_diff)
      )
    }

  io.count := countVal
}
