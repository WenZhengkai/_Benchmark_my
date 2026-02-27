// package fifo

import chisel3._
import chisel3.util._

// Define the IO interface for the Queue
class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean) extends Bundle {
  val enq = Flipped(DecoupledIO(gen.cloneType))
  val deq = DecoupledIO(gen.cloneType)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Create a memory to store the queue elements
  val ram = Mem(entries, gen)
  
  // Define pointers for enqueue and dequeue operations
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  
  val ptr_match = enq_ptr === deq_ptr
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Enqueue and dequeue valid signals
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // Ready/valid logic
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Perform enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries-1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Perform dequeue operation
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries-1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update the maybe_full register
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Implementation of flush if enabled
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Provide the output data from the queue
  io.deq.bits := ram(deq_ptr)
  
  // Calculate the number of elements in the queue
  if (isPow2(entries)) {
    // Optimize for power-of-2 entries
    val ptr_diff = enq_ptr - deq_ptr
    when (ptr_match) {
      io.count := Mux(maybe_full, entries.U, 0.U)
    }.otherwise {
      io.count := Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
    }
  } else {
    // General case for non-power-of-2 entries
    val deq_ptr_wrap = Mux(deq_ptr > enq_ptr, entries.U + enq_ptr, enq_ptr)
    io.count := Mux(empty, 0.U, deq_ptr_wrap - deq_ptr)
  }
}
