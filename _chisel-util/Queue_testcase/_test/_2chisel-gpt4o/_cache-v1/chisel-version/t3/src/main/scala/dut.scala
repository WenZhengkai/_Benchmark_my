import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  
  io.enq.ready := !full
  io.deq.valid := !empty
  
  when (io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
    when (enq_ptr === (entries-1).U) {
      enq_ptr := 0.U
    }
  }

  when (io.deq.fire()) {
    deq_ptr := deq_ptr + 1.U
    when (deq_ptr === (entries-1).U) {
      deq_ptr := 0.U
    }
  }

  val do_enq = io.enq.fire()
  val do_deq = io.deq.fire()

  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  io.deq.bits := ram(deq_ptr)

  when(hasFlush.B && io.flush.getOrElse(false.B)) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }

  def count: UInt = {
    val diff = enq_ptr - deq_ptr
    Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, diff, (entries.U + diff))
    )
  }
}
