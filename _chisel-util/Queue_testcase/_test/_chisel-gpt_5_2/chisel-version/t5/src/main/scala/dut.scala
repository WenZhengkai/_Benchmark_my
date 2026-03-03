// package dut

import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointers and full/empty tracking
  val ptrWidth = log2Ceil(entries)
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Handshake decisions
  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Default interface signals
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram.read(deq_ptr)

  // Optional flush (clears queue state)
  if (hasFlush) {
    when(io.flush) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Enqueue: write + advance
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }

  // Dequeue: advance
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // maybe_full update (only when not flushing)
  val flushActive = if (hasFlush) io.flush else false.B
  when(!flushActive) {
    when(do_enq =/= do_deq) {
      maybe_full := do_enq
    }
  }

  // Count calculation (supports non-pow2 and pow2 entries; modulo arithmetic)
  val countWidth = log2Ceil(entries + 1)
  val diff = enq_ptr - deq_ptr // wraps naturally in UInt arithmetic
  val count = Wire(UInt(countWidth.W))

  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.elsewhen(enq_ptr > deq_ptr) {
    count := (enq_ptr - deq_ptr)(countWidth - 1, 0)
  }.otherwise {
    count := (entries.U - (deq_ptr - enq_ptr))(countWidth - 1, 0)
  }

  io.count := count
}
