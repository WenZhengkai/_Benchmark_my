// package fifo

import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean) extends Bundle {
  val enq = Flipped(DecoupledIO(gen.cloneType))
  val deq = DecoupledIO(gen.cloneType)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Create a memory to store the queue entries
  val ram = Mem(entries, gen)
  
  // Define the width for the pointers based on the number of entries
  val ptrWidth = log2Ceil(entries).max(1)
  
  // Pointers for enqueue and dequeue operations
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  
  // Flag to track if the queue might be full
  val maybe_full = RegInit(false.B)
  
  // Check if pointers match (potentially empty or full)
  val ptr_match = enq_ptr === deq_ptr
  
  // Determine if the queue is empty or full
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Control signals for enqueue and dequeue operations
  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  
  // Set the ready/valid signals based on queue state
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Handle the enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Handle the dequeue operation
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Update the maybe_full flag
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Implement flush functionality if required
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Connect the dequeue data output
  io.deq.bits := ram(deq_ptr)
  
  // Calculate the count of elements in the queue
  if (isPow2(entries)) {
    // If entries is a power of 2, we can use a simpler calculation
    val ptr_diff = enq_ptr - deq_ptr
    io.count := Mux(maybe_full && ptr_match, entries.U, ptr_diff)
  } else {
    // For non-power-of-2 entries, we need to handle wrap-around
    val deq_ptr_ext = Cat(maybe_full && ptr_match, deq_ptr)
    val enq_ptr_ext = Cat(0.U(1.W), enq_ptr)
    val ptr_diff = enq_ptr_ext - deq_ptr_ext
    io.count := ptr_diff
  }
}
