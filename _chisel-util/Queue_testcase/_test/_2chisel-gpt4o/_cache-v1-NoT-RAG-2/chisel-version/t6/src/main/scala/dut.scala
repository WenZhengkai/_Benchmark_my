import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries.")
  require(isPow2(entries), "Queue entries must be a power of 2 for efficient pointer calculations.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input interface for enqueue
    val deq = Decoupled(gen)          // Output interface for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Flush signal (if enabled)
  })

  // Task 1: Memory Storage (`ram`)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))     // Pointer for enqueue
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))     // Pointer for dequeue
  val maybe_full = RegInit(false.B)                   // Tracks if the queue is full (when pointers match)

  val ptr_match = enq_ptr === deq_ptr                // Enqueue and dequeue pointers matching
  val full = ptr_match && maybe_full                 // Full condition
  val empty = ptr_match && !maybe_full               // Empty condition

  // Task 3: Full/Empty Logic
  io.enq.ready := !full                              // Queue is ready when not full
  io.deq.valid := !empty                             // Data is valid when the queue is not empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)                 // Store data into memory
    enq_ptr := enq_ptr + 1.U                        // Increment enqueue pointer (wraps automatically)
    when(!io.deq.ready || empty) {
      maybe_full := true.B                          // Update maybe_full if not dequeuing simultaneously
    }
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram.read(deq_ptr)                  // Read data from memory
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U                        // Increment dequeue pointer (wraps automatically)
    when(!io.enq.valid || full) {
      maybe_full := false.B                         // Update maybe_full if not enqueuing simultaneously
    }
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {             // Check if flush is asserted (only if enabled)
      enq_ptr := 0.U                                // Reset enqueue pointer
      deq_ptr := 0.U                                // Reset dequeue pointer
      maybe_full := false.B                         // Clear the maybe_full flag
    }
  }

  // Task 7: Count Calculation
  val ptr_diff = enq_ptr - deq_ptr                  // Calculate pointer difference
  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), ptr_diff)
}
