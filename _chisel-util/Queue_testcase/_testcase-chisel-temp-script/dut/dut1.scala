import chisel3._
import chisel3.util._

// Parameterized Queue_my Module
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be positive")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))  // Input for enqueue
    val deq = Decoupled(gen)          // Output for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush
  })

  // Internal memory for queue
  val ram = Mem(entries, gen) // Memory to hold queue data
  
  // Pointers for enqueue and dequeue
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B) // Tracks if the queue is full
  
  // Pointer matching
  val ptr_match = enq_ptr === deq_ptr
  
  // Full and empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  
  // Ready and valid signals
  io.enq.ready := !full
  io.deq.valid := !empty

  // Enqueue and dequeue conditions
  val do_enq = io.enq.fire() // True when a valid enqueue occurs
  val do_deq = io.deq.fire() // True when a valid dequeue occurs

  // Enqueue logic
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits // Write data into memory
    enq_ptr := enq_ptr + 1.U // Increment enqueue pointer
  }

  // Dequeue logic
  io.deq.bits := ram(deq_ptr) // Output data from memory
  when (do_deq) {
    deq_ptr := deq_ptr + 1.U // Increment dequeue pointer
  }

  // maybe_full logic
  when (do_enq =/= do_deq) { // Update only when enqueue or dequeue happens
    maybe_full := do_enq
  }

  // Flush mechanism (only if hasFlush is enabled)
  if (hasFlush) {
    when (io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  io.count := Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U), // Full or empty case
    Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
  )
}
