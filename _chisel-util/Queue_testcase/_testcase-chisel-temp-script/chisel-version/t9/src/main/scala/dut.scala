// package fifo

import chisel3._
import chisel3.util._

// IO interface for the Queue
class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(DecoupledIO(gen.cloneType))
  val deq = DecoupledIO(gen.cloneType)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Create a memory to hold the queue elements
  val ram = Mem(entries, gen)
  
  // Enqueue and dequeue pointers
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer matching check
  val ptr_match = enq_ptr === deq_ptr
  
  // Queue full/empty logic
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  // Decide whether to perform enqueue and dequeue operations
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid

  // Ready/valid signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // When dequeuing, read data from the memory at deq_ptr
  io.deq.bits := ram(deq_ptr)

  // Enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }

  // Dequeue operation
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }

  // Update the maybe_full flag
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Flush logic (if enabled)
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Calculate the count of elements in the queue
  if (isPow2(entries)) {
    // When entries is a power of 2, we can use bitwise operations
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(maybe_full && ptr_match, entries.U, ptr_diff)
  } else {
    // For non-power-of-2 entries, we need to handle wraparound more carefully
    val deq_ptr_inc = Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    val enq_ptr_inc = Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    
    when (ptr_match) {
      io.count := Mux(maybe_full, entries.U, 0.U)
    }.elsewhen (deq_ptr < enq_ptr) {
      io.count := enq_ptr - deq_ptr
    }.otherwise {
      io.count := (entries.U + enq_ptr) - deq_ptr
    }
  }
}
