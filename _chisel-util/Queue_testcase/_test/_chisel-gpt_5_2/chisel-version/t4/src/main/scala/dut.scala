import chisel3._
import chisel3.util._

/** Simple FIFO queue (circular buffer) with optional flush.
  *
  * IO matches chisel3.util.QueueIO(gen, entries, hasFlush)
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer width: at least 1 bit
  private val ptrW = log2Ceil(entries)
  val enq_ptr = RegInit(0.U(ptrW.W))
  val deq_ptr = RegInit(0.U(ptrW.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full  = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data at dequeue pointer (combinational read for Mem in Chisel)
  io.deq.bits := ram.read(deq_ptr)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Pointer increment with wrap
  private def wrapInc(x: UInt): UInt = {
    if (isPow2(entries)) (x + 1.U)(ptrW - 1, 0)
    else Mux(x === (entries - 1).U, 0.U, x + 1.U)
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

  // Optional flush behavior
  if (hasFlush) {
    when(io.flush) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation (0..entries)
  val count = Wire(UInt(log2Ceil(entries + 1).W))
  if (isPow2(entries)) {
    // For power-of-two depth, modular subtraction works.
    val diff = (enq_ptr - deq_ptr)(ptrW - 1, 0)
    count := Mux(full, entries.U, diff)
  } else {
    // General circular-buffer count.
    val diff = Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, enq_ptr + entries.U - deq_ptr)
    count := Mux(full, entries.U, diff)
  }

  io.count := count
}
