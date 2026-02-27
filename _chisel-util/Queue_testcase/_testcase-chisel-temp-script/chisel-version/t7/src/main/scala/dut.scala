// package fifo

import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  /** I/O to enqueue data (client is producer, and Queue object is consumer), 
    * is a decoupled source interface bundling both the data and valid signals */
  val enq = Flipped(DecoupledIO(gen.cloneType))
  
  /** I/O to dequeue data (client is consumer and Queue object is producer),
    * is a decoupled sink interface bundling the data and valid signals */
  val deq = DecoupledIO(gen.cloneType)
  
  /** The current number of elements in the queue */
  val count = Output(UInt(log2Ceil(entries + 1).W))
  
  /** Signal to flush the queue (reset the pointers) if flush capability is enabled */
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory to store the queue elements
  val ram = Mem(entries, gen)
  
  // Pointers for enqueue and dequeue operations
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  // Flag to track if the queue might be full
  val maybe_full = RegInit(false.B)
  
  // Determine if the pointers match (could indicate either full or empty)
  val ptr_match = enq_ptr === deq_ptr
  
  // Queue state flags
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Control signals for enqueue and dequeue operations
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // Ready/valid logic
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries-1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Dequeue operation - read data from memory
  io.deq.bits := ram(deq_ptr)
  
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries-1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update full status based on enqueue and dequeue operations
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Flush logic if enabled
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Calculate the number of elements in the queue
  if (isPow2(entries)) {
    // Efficient calculation for power-of-2 sized queues
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr > enq_ptr, 
          entries.U + enq_ptr - deq_ptr, 
          enq_ptr - deq_ptr)
    )
  } else {
    // General case for non-power-of-2 sized queues
    val deq_ptr_ext = Cat(maybe_full && ptr_match, deq_ptr)
    val enq_ptr_ext = Cat(0.U(1.W), enq_ptr)
    val ptr_diff = enq_ptr_ext - deq_ptr_ext
    
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr_ext < deq_ptr_ext, 
          entries.U + ptr_diff, 
          ptr_diff)
    )
  }
}
