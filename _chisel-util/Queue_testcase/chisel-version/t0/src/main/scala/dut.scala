// package fifo

import chisel3._
import chisel3.util._

/** A hardware queue with standard enqueue and dequeue interfaces
 * @param gen the type of elements stored in the queue
 * @param entries the maximum number of entries in the queue
 * @param hasFlush indicates whether to include the flush feature
 */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Create a synchronous memory for data storage
  val ram = Mem(entries, gen)
  
  // Use counters to track enqueue and dequeue positions
  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  
  // Track if pointers are in the same position
  val ptr_match = enq_ptr.value === deq_ptr.value
  
  // Additional state to differentiate between full and empty when pointers match
  val maybe_full = RegInit(false.B)
  
  // Queue full/empty signals
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  // Connect status signals to outputs
  io.count := Mux(
    ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    Mux(
      enq_ptr.value > deq_ptr.value,
      enq_ptr.value - deq_ptr.value,
      entries.U + enq_ptr.value - deq_ptr.value
    )
  )
  
  io.empty := empty
  io.full := full
  
  // Ready/valid signals for interface
  io.deq.valid := !empty
  io.enq.ready := !full
  
  // Read data from memory for dequeue operation
  io.deq.bits := ram(deq_ptr.value)
  
  // Control signals for enqueue and dequeue operations
  val do_enq = io.enq.fire
  val do_deq = io.deq.fire
  
  // Default for flush signal (will be overridden if hasFlush is true)
  val do_flush = WireDefault(false.B)
  
  // Implement flush functionality if enabled
  if (hasFlush) {
    do_flush := io.flush
    when (io.flush) {
      enq_ptr.reset()
      deq_ptr.reset()
      maybe_full := false.B
    }
  }
  
  // Handle enqueue operation
  when (do_enq) {
    ram(enq_ptr.value) := io.enq.bits
    enq_ptr.inc()
  }
  
  // Handle dequeue operation
  when (do_deq) {
    deq_ptr.inc()
  }
  
  // Update full tracking state
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Assertions for verification
  if (isPow2(entries)) {
    // For power of 2 sizes, we can directly compute count
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(
        enq_ptr.value > deq_ptr.value,
        enq_ptr.value - deq_ptr.value,
        entries.U + enq_ptr.value - deq_ptr.value
      )
    )
  } else {
    // For non-power of 2 sizes, we need to handle wrapping differently
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(
        enq_ptr.value > deq_ptr.value,
        enq_ptr.value - deq_ptr.value,
        entries.U + enq_ptr.value - deq_ptr.value
      )
    )
  }
  
  // Debug assertions (when compiled with assertions enabled)
  assert(!(io.enq.fire && io.full), "Enqueue fire when full")
  assert(!(io.deq.fire && io.empty), "Dequeue fire when empty")
  
  if (hasFlush) {
    assert(!(io.enq.fire && io.flush), "Enqueue fire when flush")
    assert(!(io.deq.fire && io.flush), "Dequeue fire when flush")
  }
}

/** IO interface for the Queue
 * @param gen the type of elements stored in the queue
 * @param entries the maximum number of entries in the queue
 * @param hasFlush indicates whether to include the flush feature
 */
class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq = Flipped(DecoupledIO(gen))
  val deq = DecoupledIO(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val empty = Output(Bool())
  val full = Output(Bool())
  val flush = if (hasFlush) Some(Input(Bool())) else None
}
