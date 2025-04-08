import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive number")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input for enqueue
    val deq = Decoupled(gen)          // Output for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // ---------------------------------------------
  // Task 1: Memory Storage
  // ---------------------------------------------
  val ram = Mem(entries, gen) // Memory block to store queue elements

  // ---------------------------------------------
  // Task 2: Pointer Management
  // ---------------------------------------------
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Tracks if the queue is full

  val ptr_match = enq_ptr === deq_ptr // True if enqueue and dequeue pointers match

  // ---------------------------------------------
  // Task 3: Full/Empty Logic
  // ---------------------------------------------
  val full = ptr_match && maybe_full // Queue is full
  val empty = ptr_match && !maybe_full // Queue is empty

  io.enq.ready := !full // Queue is ready for enqueue if not full
  io.deq.valid := !empty // Dequeue is valid if queue is not empty

  // ---------------------------------------------
  // Task 4: Enqueue Logic
  // ---------------------------------------------
  val do_enq = io.enq.valid && io.enq.ready // Valid enqueue condition

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits // Write data to memory at enqueue pointer
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment enqueue pointer with wrap-around
  }

  // Update maybe_full for enqueue
  when(do_enq && !(io.deq.ready && io.deq.valid)) {
    maybe_full := true.B
  }

  // ---------------------------------------------
  // Task 5: Dequeue Logic
  // ---------------------------------------------
  val do_deq = io.deq.ready && io.deq.valid // Valid dequeue condition

  io.deq.bits := ram(deq_ptr) // Read data from memory at dequeue pointer

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment dequeue pointer with wrap-around
  }

  // Update maybe_full for dequeue
  when(do_deq && !(io.enq.valid && io.enq.ready)) {
    maybe_full := false.B
  }

  // ---------------------------------------------
  // Task 6: Flush Mechanism (Conditional)
  // ---------------------------------------------
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) { // Check if flush input is high
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // ---------------------------------------------
  // Task 7: Count Calculation
  // ---------------------------------------------
  val diff = Mux(enq_ptr >= deq_ptr,
    enq_ptr - deq_ptr,                        // Normal difference if enqueue pointer >= dequeue pointer
    (entries.U + enq_ptr) - deq_ptr)          // Wrap-around case

  io.count := Mux(full, entries.U, diff) // If full, count is max entries, else count is the difference
}
