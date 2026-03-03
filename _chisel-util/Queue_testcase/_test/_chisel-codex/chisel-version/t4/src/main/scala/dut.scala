import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None

  override def cloneType: this.type =
    (new QueueIO(gen, entries, hasFlush)).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ptrWidth = math.max(1, log2Ceil(entries))
  private val ram      = Mem(entries, gen)

  private val enq_ptr    = RegInit(0.U(ptrWidth.W))
  private val deq_ptr    = RegInit(0.U(ptrWidth.W))
  private val maybe_full = RegInit(false.B)

  private val flush = if (hasFlush) io.flush.get else false.B

  private def ptrInc(ptr: UInt): UInt = {
    if (entries == 1) {
      0.U
    } else if (isPow2(entries)) {
      ptr + 1.U
    } else {
      Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
    }
  }

  private val ptr_match = enq_ptr === deq_ptr
  private val empty     = ptr_match && !maybe_full
  private val full      = ptr_match && maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  private val do_enq = io.enq.fire && !flush
  private val do_deq = io.deq.fire && !flush

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

  when(flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }

  private val countVal = if (isPow2(entries)) {
    Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), enq_ptr - deq_ptr)
  } else {
    Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
    )
  }
  io.count := countVal
}
