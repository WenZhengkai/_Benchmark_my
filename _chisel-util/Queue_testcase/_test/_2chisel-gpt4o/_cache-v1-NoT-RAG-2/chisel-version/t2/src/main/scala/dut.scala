import chisel3._
import chisel3.util._

class dut[T <: Data](
    gen: T,
    entries: Int,
    hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Queue must have a positive number of entries.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input: enqueue interface
    val deq = Decoupled(gen)          // Output: dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // --------------------------------------------------------------------
  // Task 1: Memory Storage (`ram`)
  // --------------------------------------------------------------------
  val ram = Mem(entries, gen)

  // --------------------------------------------------------------------
  // Task 2: Pointer Management
  // --------------------------------------------------------------------
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Flag for fullness tracking
  val ptr_match = enq_ptr === deq_ptr             // Pointer match condition

  // --------------------------------------------------------------------
  // Task 3: Full/Empty Logic
  // --------------------------------------------------------------------
  val full = ptr_match && maybe_full              // Full: pointers match and `maybe_full` is true
  val empty = ptr_match && !maybe_full            // Empty: pointers match and `maybe_full` is false

  io.enq.ready := !full                           // Ready to enqueue if not full
  io.deq.valid := !empty                          // Valid to dequeue if not empty

  // --------------------------------------------------------------------
  // Task 4: Enqueue Logic
  // --------------------------------------------------------------------
  val do_enq = io.enq.valid && io.enq.ready       // Condition for enqueuing data

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits                   // Write input data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment enqueue pointer with wrap-around
  }

  when(do_enq && !io.deq.fire) {                  // Enqueuing without simultaneous dequeue
    maybe_full := true.B                          // Update `maybe_full` to true
  }

  // --------------------------------------------------------------------
  // Task 5: Dequeue Logic
  // --------------------------------------------------------------------
  val do_deq = io.deq.ready && io.deq.valid       // Condition for dequeuing data

  io.deq.bits := ram(deq_ptr)                     // Output data from memory

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment dequeue pointer with wrap-around
  }

  when(do_deq && !io.enq.fire) {                  // Dequeuing without simultaneous enqueue
    maybe_full := false.B                         // Update `maybe_full` to false
  }

  // --------------------------------------------------------------------
  // Task 6: Flush Mechanism (Conditional)
  // --------------------------------------------------------------------
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {           // On flush signal
      enq_ptr := 0.U                              // Reset enqueue pointer
      deq_ptr := 0.U                              // Reset dequeue pointer
      maybe_full := false.B                       // Clear the `maybe_full` flag
    }
  }

  // --------------------------------------------------------------------
  // Task 7: Count Calculation
  // --------------------------------------------------------------------
  val ptr_diff = enq_ptr - deq_ptr                // Pointer difference

  if (isPow2(entries)) {                          // If `entries` is a power of two
    io.count := Mux(maybe_full, entries.U, 0.U) + ptr_diff
  } else {                                        // If `entries` is not a power of two
    io.count := Mux(
      ptr_match,                                  // If pointers match
      Mux(maybe_full, entries.U, 0.U),           // If `maybe_full`, return `entries`, else `0`
      Mux(deq_ptr > enq_ptr,                     // Handle wrap-around
        entries.U - (deq_ptr - enq_ptr),
        enq_ptr - deq_ptr
      )
    )
  }
}
