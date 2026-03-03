// package dut

import chisel3._
import chisel3.util._

/** Simple FIFO queue (ring buffer) with optional flush.
  *
  * Interface reuses QueueIO(gen, entries, hasFlush).
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer widths
  private val ptrWidth = log2Ceil(entries)

  // Pointers and full-tracking bit
  val enq_ptr    = RegInit(0.U(ptrWidth.W))
  val deq_ptr    = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  // Pointer compare and full/empty
  val ptr_match = enq_ptr === deq_ptr
  val full      = ptr_match && maybe_full
  val empty     = ptr_match && !maybe_full

  // Handshakes
  io.enq.ready := !full
  io.deq.valid := !empty

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Read data (combinational read from Mem; this matches the classic Queue impl)
  io.deq.bits := ram.read(deq_ptr)

  // Pointer increment with wrap
  private def incPtr(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := incPtr(enq_ptr)
  }
  when(do_deq) {
    deq_ptr := incPtr(deq_ptr)
  }

  // maybe_full update: toggles when exactly one of enq/deq happens
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Optional flush
  if (hasFlush) {
    when(io.flush) {
      enq_ptr    := 0.U
      deq_ptr    := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation (number of valid elements)
  val count = Wire(UInt((log2Ceil(entries + 1)).W))
  if (isPow2(entries)) {
    // For power-of-2 depths, modulo arithmetic works naturally
    val diff = enq_ptr - deq_ptr
    count := Mux(full, entries.U, Mux(empty, 0.U, diff))
  } else {
    // General ring-buffer count
    val ahead = enq_ptr >= deq_ptr
    val diff  = enq_ptr - deq_ptr
    val wrap  = (enq_ptr + entries.U(ptrWidth.W)) - deq_ptr
    val raw   = Mux(ahead, diff, wrap)
    count := Mux(full, entries.U, Mux(empty, 0.U, raw))
  }

  io.count := count
}
