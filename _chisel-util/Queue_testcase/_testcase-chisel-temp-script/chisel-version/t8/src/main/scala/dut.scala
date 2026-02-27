// package fifo

import chisel3._
import chisel3.util._

/** QueueIO interface for the FIFO queue */
class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  /** I/O to enqueue data */
  val enq = Flipped(new DecoupledIO(gen))
  /** I/O to dequeue data */
  val deq = new DecoupledIO(gen)
  /** The current amount of data in the queue */
  val count = Output(UInt(log2Ceil(entries + 1).W))
  
  /** Flush signal to clear the queue if hasFlush is true */
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

/** FIFO Queue module implementation */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Storage for the queue elements
  val ram = Mem(entries, gen)
  
  // Pointers for enqueueing and dequeueing
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  // Flag to track if the queue is potentially full
  val maybe_full = RegInit(false.B)
  
  // Determine if pointers match
  val ptr_match = enq_ptr === deq_ptr
  
  // Determine queue state (full/empty)
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Control signals for enqueue and dequeue operations
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // Set ready/valid signals based on queue state
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Connect dequeue data to output
  when (empty) {
    io.deq.bits := DontCare
  } .otherwise {
    io.deq.bits := ram(deq_ptr)
  }
  
  // Handle enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Handle dequeue operation
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update maybe_full based on operations
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Implement flush functionality if needed
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Calculate the number of elements in the queue
  if (isPow2(entries)) {
    // Efficient count calculation for power-of-2 entries
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(maybe_full && ptr_match, entries.U, ptr_diff)
  } else {
    // General count calculation for non-power-of-2 entries
    val deq_ptr_ext = Cat(maybe_full && ptr_match, deq_ptr)
    val enq_ptr_ext = Cat(0.U(1.W), enq_ptr)
    val ptr_diff = enq_ptr_ext - deq_ptr_ext
    io.count := Mux(ptr_diff.head(1).asBool, entries.U + ptr_diff, ptr_diff)
  }
}
