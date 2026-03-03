import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Input(Bool()) else null
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)

  private val ptrWidth = math.max(1, log2Ceil(entries))
  val enq_ptr    = RegInit(0.U(ptrWidth.W))
  val deq_ptr    = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  def wrapInc(ptr: UInt): UInt = {
    if (entries == 1) 0.U
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  val ptr_match = enq_ptr === deq_ptr
  val empty     = ptr_match && !maybe_full
  val full      = ptr_match && maybe_full
  val flushReq  = if (hasFlush) io.flush else false.B

  io.enq.ready := !full
  io.deq.valid := !empty && !flushReq
  io.deq.bits  := ram(deq_ptr)

  val do_enq = io.enq.fire && !flushReq
  val do_deq = io.deq.fire && !flushReq

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

  when(flushReq) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }

  val ptr_diff = enq_ptr - deq_ptr
  val countCalc = if (isPow2(entries)) {
    Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
  } else {
    Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr > enq_ptr, entries.U + ptr_diff, ptr_diff)
    )
  }

  io.count := Mux(flushReq, 0.U, countCalc)
}
