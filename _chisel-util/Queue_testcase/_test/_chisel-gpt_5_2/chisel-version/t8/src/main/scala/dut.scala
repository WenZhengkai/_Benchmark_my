import chisel3._
import chisel3.util._

/** FIFO queue dut */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointers and full/empty tracking
  val ptrBits  = log2Ceil(entries)
  val enq_ptr  = RegInit(0.U(ptrBits.W))
  val deq_ptr  = RegInit(0.U(ptrBits.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full  = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Handshakes
  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data (combinational read from Mem is OK in Chisel;
  // tool may infer appropriate RAM/regs)
  io.deq.bits := ram(deq_ptr)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Helper: increment pointer with wraparound
  def incr(ptr: UInt): UInt = {
    if (isPow2(entries)) (ptr + 1.U)(ptrBits - 1, 0)
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  // Enqueue/dequeue pointer updates
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := incr(enq_ptr)
  }
  when(do_deq) {
    deq_ptr := incr(deq_ptr)
  }

  // maybe_full update (only changes when enq/deq are not both happening)
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

  // Count calculation
  val diff = enq_ptr - deq_ptr
  val count = Wire(UInt(log2Ceil(entries + 1).W))

  if (isPow2(entries)) {
    // For power-of-two depth, pointer subtraction already wraps correctly.
    count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), diff)
  } else {
    // For non-power-of-two depth, handle wrap explicitly.
    val enq_ge_deq = enq_ptr >= deq_ptr
    val linear = Mux(enq_ge_deq, enq_ptr - deq_ptr, enq_ptr + entries.U - deq_ptr)
    count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), linear)
  }

  io.count := count
}
