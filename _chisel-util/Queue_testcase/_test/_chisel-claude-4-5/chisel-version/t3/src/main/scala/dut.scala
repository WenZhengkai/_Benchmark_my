import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None

  override def cloneType: this.type = 
    new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer match logic
  val ptr_match = enq_ptr === deq_ptr

  // Full/Empty logic
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)

  // Ready/Valid signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Data dequeue
  io.deq.bits := ram(deq_ptr)

  // Flush logic
  val do_flush = if (hasFlush) io.flush.get else false.B

  when(do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }.otherwise {
    // Data enqueue
    when(do_enq) {
      ram(enq_ptr) := io.enq.bits
      enq_ptr := enq_ptr + 1.U
    }

    // Data dequeue
    when(do_deq) {
      deq_ptr := deq_ptr + 1.U
    }

    // Update maybe_full
    when(do_enq =/= do_deq) {
      maybe_full := do_enq
    }
  }

  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  val count = Wire(UInt(log2Ceil(entries + 1).W))

  if (isPow2(entries)) {
    // When entries is a power of 2, we can use simpler logic
    count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
    )
  } else {
    // For non-power-of-2 entries
    count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, ptr_diff, entries.U - (deq_ptr - enq_ptr))
    )
  }

  io.count := count
}

// Helper object for instantiation
object dut {
  def apply[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false): dut[T] = {
    new dut(gen, entries, hasFlush)
  }
}
