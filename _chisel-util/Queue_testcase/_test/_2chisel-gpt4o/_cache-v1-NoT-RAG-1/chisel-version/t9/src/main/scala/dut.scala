import chisel3._
import chisel3.util._

/**
 * dut Module
 * A parameterized FIFO with optional flush capability.
 * @param gen      The data type of the elements stored in the queue.
 * @param entries  The number of entries the queue can hold.
 * @param hasFlush Whether the queue supports a flush operation.
 */
class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new Bundle {
    // Enqueue interface
    val enq = Flipped(Decoupled(gen)) // Input: valid and bits, Output: ready
    
    // Dequeue interface
    val deq = Decoupled(gen)         // Output: valid and bits, Input: ready

    // Current queue element count
    val count = Output(UInt(log2Ceil(entries + 1).W))

    // Optional flush signal
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // === Task 1: Implement Memory Storage (`ram`) ===
  val ram = Mem(entries, gen)

  // === Task 2: Pointer Management ===
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))  // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))  // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Indicates if the queue might be full
  val ptr_match = enq_ptr === deq_ptr             // Are the pointers at the same position?

  // === Task 3: Full/Empty Logic ===
  val full = ptr_match && maybe_full              // Queue is full
  val empty = ptr_match && !maybe_full            // Queue is empty
  io.enq.ready := !full                           // Ready to enqueue if queue is not full
  io.deq.valid := !empty                          // Valid data to dequeue if queue is not empty

  // === Task 4: Enqueue Logic ===
  val do_enq = io.enq.valid && io.enq.ready       // Can enqueue
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)               // Write input data to RAM
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer, wrap around
  }

  // === Task 5: Dequeue Logic ===
  val do_deq = io.deq.ready && io.deq.valid       // Can dequeue
  io.deq.bits := ram.read(deq_ptr, !do_deq)       // Read from RAM, asynchronous read but delayed for clock edge
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer, wrap around
  }

  // === Task 4 & 5: Update `maybe_full` ===
  when(do_enq =/= do_deq) {                       // Enqueue without dequeue, or vice versa
    maybe_full := do_enq
  }

  // === Task 6: Flush Mechanism (Conditional) ===
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // === Task 7: Count Calculation ===
  val wrap_around = enq_ptr < deq_ptr             // Check for wrap-around case
  io.count := Mux(
    ptr_match,
    Mux(maybe_full, entries.U, 0.U),              // If pointers match, count depends on `maybe_full`
    Mux(wrap_around, entries.U + enq_ptr - deq_ptr, enq_ptr - deq_ptr) // Handle wrap-around
  )
}

// === Testbench for the `dut` Module ===
// During real hardware development, you would want to write unit tests using a Chisel test framework.
// For example: This can be tested using Chisel's `Driver` and `iotesters` for simulation.

