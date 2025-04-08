import chisel3._
import chisel3.util._

// dut Module
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  // I/O definition
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))            // Input for enqueue (valid/ready handshake)
    val deq = Decoupled(gen)                    // Output for dequeue (valid/ready handshake)
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // --- Task 1: Implement Memory Storage ---
  val ram = Mem(entries, gen) // Memory block for queue storage

  // --- Task 2: Pointer Management ---
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)              // To track fullness status
  val ptr_match = enq_ptr === deq_ptr            // Pointer equality (used for empty/full logic)

  // --- Task 3: Full/Empty Logic ---
  val full = ptr_match && maybe_full             // Full condition
  val empty = ptr_match && !maybe_full           // Empty condition

  // Input/output control signals
  io.enq.ready := !full                          // Ready to enqueue when not full
  io.deq.valid := !empty                         // Valid to dequeue when not empty

  // --- Task 4: Enqueue Logic ---
  val do_enq = io.enq.valid && io.enq.ready      // Enqueue operation

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)              // Write data to RAM
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer (with wrap-around)
    when(!io.deq.valid || !io.deq.ready) {
      maybe_full := true.B                       // Update fullness only if not simultaneously dequeuing
    }
  }

  // --- Task 5: Dequeue Logic ---
  val do_deq = io.deq.ready && io.deq.valid      // Dequeue operation

  io.deq.bits := ram.read(deq_ptr)              // Read data from RAM
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer (with wrap-around)
    when(!io.enq.valid || !io.enq.ready) {
      maybe_full := false.B                      // Update fullness only if not simultaneously enqueuing
    }
  }

  // --- Task 6: Flush Mechanism (Conditional) ---
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {          // Check if flush signal is asserted
      enq_ptr := 0.U                             // Reset enqueue pointer
      deq_ptr := 0.U                             // Reset dequeue pointer
      maybe_full := false.B                      // Clear the full status
    }
  }

  // --- Task 7: Count Calculation ---
  val diff = Mux(enq_ptr >= deq_ptr,
                 enq_ptr - deq_ptr,
                 (entries.U + enq_ptr) - deq_ptr) // Calculate difference between pointers
  io.count := Mux(full, entries.U, diff)          // If full, count is max capacity; else, pointer difference
}

