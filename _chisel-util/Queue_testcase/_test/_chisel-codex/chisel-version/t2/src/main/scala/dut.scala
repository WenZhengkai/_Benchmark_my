import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq   = Flipped(Decoupled(gen.cloneType))
  val deq   = Decoupled(gen.cloneType)
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

  private val ptr_match = enq_ptr === deq_ptr
  private val empty     = ptr_match && !maybe_full
  private val full      = ptr_match && maybe_full

  private val flushReq = if (hasFlush) io.flush.get else false.B

  io.enq.ready := !full && !flushReq
  io.deq.valid := !empty && !flushReq
  io.deq.bits  := ram.read(deq_ptr)

  private val do_enq = io.enq.fire && !flushReq
  private val do_deq = io.deq.fire && !flushReq

  private def wrapInc(x: UInt): UInt = {
    if (entries == 1) 0.U(ptrWidth.W)
    else Mux(x === (entries - 1).U, 0.U(ptrWidth.W), x + 1.U)
  }

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := wrapInc(enq_ptr)
  }

  when(do_deq) {
    deq_ptr := wrapInc(deq_ptr)
  }

  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr    := 0.U
      deq_ptr    := 0.U
      maybe_full := false.B
    }
  }

  private val ptr_diff =
    if (isPow2(entries)) {
      enq_ptr - deq_ptr
    } else {
      Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
    }

  private val countCalc = Mux(
    ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    ptr_diff
  )

  io.count := Mux(flushReq, 0.U, countCalc)
}
