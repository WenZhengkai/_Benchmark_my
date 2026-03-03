import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  if (hasFlush) {
    val flush = Input(Bool())
  }

  override def cloneType: this.type =
    (new QueueIO(gen, entries, hasFlush)).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)

  val ptrWidth = math.max(1, log2Ceil(entries))
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val empty = ptr_match && !maybe_full
  val full  = ptr_match && maybe_full

  val flush = if (hasFlush) io.flush else false.B

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  def ptrInc(ptr: UInt): UInt = {
    if (entries == 1) 0.U
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  when(flush) {
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
  if (isPow2(entries)) {
    io.count := Cat(maybe_full && ptr_match, ptr_diff)
  } else {
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr > enq_ptr, entries.U + ptr_diff, ptr_diff)
    )
  }
}
