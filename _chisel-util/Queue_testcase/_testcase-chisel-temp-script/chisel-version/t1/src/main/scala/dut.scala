import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  /** I/O to enqueue data (client is producer, and Queue object is consumer), 
    * is only valid when queue is not full
    */
  val enq = Flipped(DecoupledIO(gen.cloneType))
  
  /** I/O to dequeue data (client is consumer and Queue object is producer),
    * is only valid when queue is not empty
    */
  val deq = DecoupledIO(gen.cloneType)
  
  /** The current amount of data in the queue */
  val count = Output(UInt(log2Ceil(entries + 1).W))
  
  /** Signal to flush the queue (reset internal state) */
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Create a memory to store the queue elements
  val ram = Mem(entries, gen)
  
  // Enqueue and dequeue pointers
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  // Track if the queue is potentially full
  val maybe_full = RegInit(false.B)
  
  // Check if pointers match
  val ptr_match = enq_ptr === deq_ptr
  
  // Determine full and empty states
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Connect ready/valid signals
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Action signals
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // When enqueuing, write to memory and increment pointer
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries-1).U, 0.U, enq_ptr + 1.U)
  }
  
  // When dequeuing, increment dequeue pointer
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries-1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update maybe_full flag
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Connect dequeue data output
  io.deq.bits := ram(deq_ptr)
  
  // Implement flush functionality if enabled
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Calculate the count of elements in the queue
  if (isPow2(entries)) {
    // Efficient calculation for power of 2 entries
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(maybe_full && ptr_match, entries.U, ptr_diff)
  } else {
    // General case
    val deq_ptr_inc = Mux(deq_ptr === (entries-1).U, 0.U, deq_ptr + 1.U)
    val enq_ptr_inc = Mux(enq_ptr === (entries-1).U, 0.U, enq_ptr + 1.U)
    
    when (ptr_match) {
      io.count := Mux(maybe_full, entries.U, 0.U)
    }.elsewhen (deq_ptr > enq_ptr) {
      io.count := entries.U + enq_ptr - deq_ptr
    }.otherwise {
      io.count := enq_ptr - deq_ptr
    }
  }
}
