import chisel3._
import chisel3.util._

/** FIFO queue (circular buffer) with optional flush.
  *
  * Uses pointers + maybe_full to distinguish full vs empty when pointers match.
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer width: enough to address [0, entries-1]
  private val ptrWidth = log2Ceil(entries)
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  // Pointer match + full/empty
  val ptr_match = enq_ptr === deq_ptr
  val full  = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Handshake decisions
  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Default interface signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data at deq_ptr (asynchronous read Mem semantics)
  io.deq.bits := ram(deq_ptr)

  // Next pointer function with wrap-around (works for any entries > 0)
  private def inc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  // Perform enqueue: write RAM and advance enq_ptr
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := inc(enq_ptr)
  }

  // Perform dequeue: advance deq_ptr
  when(do_deq) {
    deq_ptr := inc(deq_ptr)
  }

  // Update maybe_full
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Optional flush
  if (hasFlush) {
    when(io.flush) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation (0..entries)
  // Based on circular difference; special-cased for full.
  val countWidth = log2Ceil(entries + 1)
  val diff = Wire(UInt(countWidth.W))
  when(enq_ptr >= deq_ptr) {
    diff := (enq_ptr - deq_ptr)(countWidth - 1, 0)
  }.otherwise {
    diff := (enq_ptr + entries.U - deq_ptr)(countWidth - 1, 0)
  }
  io.count := Mux(full, entries.U, diff)

  // (Optional) expose status if QueueIO provides them; QueueIO already includes count/flush.
  // full/empty are inherently represented by ready/valid.
}
