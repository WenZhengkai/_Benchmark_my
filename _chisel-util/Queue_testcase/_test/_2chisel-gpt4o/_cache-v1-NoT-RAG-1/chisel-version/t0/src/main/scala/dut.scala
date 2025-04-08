import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have at least one entry")
  require(isPow2(entries), "Queue entries must be a power of 2 for this implementation")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Enqueue interface: valid/ready handshake, with data
    val deq = Decoupled(gen)          // Dequeue interface: valid/ready handshake, with data
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of valid entries in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Task 1: Memory Storage
  val ram = Mem(entries, gen) // Memory to store queue elements

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Pointer for enqueue position
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Pointer for dequeue position
  val maybe_full = RegInit(false.B)               // Tracks if the queue might be full
  val ptr_match = enq_ptr === deq_ptr             // Check if pointers are equal

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full              // Queue is full if pointers match and maybe_full is true
  val empty = ptr_match && !maybe_full            // Queue is empty if pointers match and maybe_full is false
  io.enq.ready := !full                           // Ready to enqueue if not full
  io.deq.valid := !empty                          // Valid data to dequeue if not empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready       // Condition for enqueue to happen
  when (do_enq) {
    ram.write(enq_ptr, io.enq.bits)              // Write input data to RAM at enqueue pointer
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer with wrapping
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid       // Condition for dequeue to happen
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer with wrapping
  }

  // Update maybe_full based on enqueue/dequeue conditions
  when (do_enq =/= do_deq) { 
    maybe_full := do_enq // Set to true if enqueuing without dequeuing, false otherwise
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when (io.flush.getOrElse(false.B)) { // Check if flush is asserted
      enq_ptr := 0.U                      // Reset enqueue pointer to 0
      deq_ptr := 0.U                      // Reset dequeue pointer to 0
      maybe_full := false.B               // Clear maybe_full flag
    }
  }

  // Task 7: Count Calculation
  val ptr_diff = enq_ptr - deq_ptr                       // Difference between enqueue and dequeue pointers
  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), // If pointers match, check maybe_full
    Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff))   // Handle wrap-around

  // Output the data at dequeue pointer
  io.deq.bits := ram.read(deq_ptr)                     // Read data from RAM at dequeue pointer
}
