// package fifo

import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  /** I/O to enqueue data (client is producer, and Queue object is consumer), 
    * is decoupled and will be ready for as long as the queue is not full
    */
  val enq = Flipped(Decoupled(gen))
  
  /** I/O to dequeue data (client is consumer and Queue object is producer),
    * is decoupled and will be valid for as long as the queue is not empty
    */
  val deq = Decoupled(gen)
  
  /** The current number of elements in the queue */
  val count = Output(UInt(log2Ceil(entries + 1).W))
  
  /** Signal to flush the queue */
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Ensure entries is positive
  require(entries > 0, "Queue entries must be greater than zero")

  // Calculate the number of pointer bits needed
  val pointerBits = log2Ceil(entries)
  
  // Create RAM for queue data storage
  val ram = Mem(entries, gen)
  
  // Initialize pointers and tracking state
  val enq_ptr = RegInit(0.U(pointerBits.W))
  val deq_ptr = RegInit(0.U(pointerBits.W))
  val maybe_full = RegInit(false.B)
  
  // Determine if pointers have same value (could be empty or full)
  val ptr_match = enq_ptr === deq_ptr
  
  // Queue state flags
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Flow control signals
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // Handle enqueue operations
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries-1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Handle dequeue operations
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries-1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update maybe_full state
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Handle flush operation if enabled
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Connect I/O ports
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  
  // Calculate and output the current count
  if (isPow2(entries)) {
    // Special case for power-of-2 entries
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(full, entries.U, 
                    Mux(ptr_match, 0.U, 
                        Mux(enq_ptr > deq_ptr, ptr_diff, 
                            entries.U + ptr_diff)))
  } else {
    // General case for non-power-of-2 entries
    val deq_ptr_wrap = deq_ptr +& entries.U
    val enq_ptr_wrap = enq_ptr +& entries.U
    val ptr_diff = Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, 
                        Mux(full, entries.U, enq_ptr_wrap - deq_ptr))
    io.count := ptr_diff
  }
}
