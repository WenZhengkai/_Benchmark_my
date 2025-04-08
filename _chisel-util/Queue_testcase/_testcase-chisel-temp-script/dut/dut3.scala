import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input: enqueue interface
    val deq = Decoupled(gen)          // Output: dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Output: number of elements in queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Task 1: Memory Storage
  val ram = Mem(entries, gen) // Create a memory block for storing elements

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B) // Tracks whether the queue is maybe full
  val ptr_match = enq_ptr === deq_ptr // True if enqueue and dequeue pointers are equal

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full // Queue is full if pointers match and maybe_full is true
  val empty = ptr_match && !maybe_full // Queue is empty if pointers match and maybe_full is false

  io.enq.ready := !full // Ready to enqueue when not full
  io.deq.valid := !empty // Valid to dequeue when not empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready // Enqueue operation occurs on this condition
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits) // Write data to RAM at enqueue pointer
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer, wrap around if necessary
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid // Dequeue operation occurs on this condition
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer, wrap around if necessary
  }

  // Update maybe_full based on enqueue and dequeue operations
  when(do_enq && !do_deq) {
    maybe_full := true.B // Enqueue without dequeue
  }.elsewhen(!do_enq && do_deq) {
    maybe_full := false.B // Dequeue without enqueue
  }

  // Task 6: Flush Mechanism (if enabled)
  if (hasFlush) {
    when(io.flush.get) { // Reset pointers and clear maybe_full if flush signal is asserted
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val diff = Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, (entries.U + enq_ptr) - deq_ptr) // Compute difference
  io.count := Mux(full, entries.U, diff) // If full, count is max entries, otherwise use computed difference

  // Hook up dequeue output
  io.deq.bits := ram.read(deq_ptr) // Read data from RAM at dequeue pointer
}


