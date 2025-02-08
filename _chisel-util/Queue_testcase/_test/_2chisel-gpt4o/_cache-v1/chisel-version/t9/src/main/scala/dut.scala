import chisel3._
import chisel3.util._

class QueueIO[T <: Data](private val gen: T, val entries: Int, val hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val flush = if (hasFlush) Some(Input(Bool())) else None

  override def cloneType: this.type = new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have strictly positive number of entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  val do_enq = io.enq.fire()
  val do_deq = io.deq.fire()

  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }

  when (do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  val count = Mux(ptr_match,
    Mux(maybe_full, entries.asUInt, 0.U),
    Mux(deq_ptr > enq_ptr, entries.asUInt + enq_ptr - deq_ptr, enq_ptr - deq_ptr)
  )

  io.enq.ready := !full
  io.deq.valid := !empty

  io.deq.bits := ram(deq_ptr)

  // Print statements for debugging can be added as needed
}

