import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive number.")

  // I/O definition
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input for enqueue (valid and bits)
    val deq = Decoupled(gen)         // Output for dequeue (ready and bits)
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointers and full/empty logic
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Indicates if the queue may be full

  val ptr_match = enq_ptr === deq_ptr             // True if enqueue and dequeue pointers are equal
  val full = ptr_match && maybe_full              // Queue is full condition
  val empty = ptr_match && !maybe_full            // Queue is empty condition

  // Enqueue/dequeue signals
  val do_enq = io.enq.valid && io.enq.ready       // Enqueue is happening
  val do_deq = io.deq.valid && io.deq.ready       // Dequeue is happening

  // Enqueue logic
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits                   // Write data to RAM
    enq_ptr := WrapInc(enq_ptr, entries)          // Wrap-around increment of enqueue pointer
  }

  // Dequeue logic
  when(do_deq) {
    deq_ptr := WrapInc(deq_ptr, entries)          // Wrap-around increment of dequeue pointer
  }

  // maybe_full update
  when(do_enq =/= do_deq) {
    maybe_full := do_enq                         // Update `maybe_full` based on enqueue/dequeue
  }

  // Flush logic (if enabled)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U                             // Reset enqueue pointer
      deq_ptr := 0.U                             // Reset dequeue pointer
      maybe_full := false.B                      // Clear maybe_full flag
    }
  }

  // Outputs
  io.enq.ready := !full                          // Ready signal for enqueue
  io.deq.valid := !empty                         // Valid signal for dequeue
  io.deq.bits := ram(deq_ptr)                    // Data to be dequeued
  io.count := Mux(ptr_match,                    // Count calculation for the queue
    Mux(maybe_full, entries.U, 0.U),
    Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U + enq_ptr - deq_ptr)
  )

  // Helper function for pointer wrapping
  private def WrapInc(ptr: UInt, n: Int): UInt = {
    Mux(ptr === (n - 1).U, 0.U, ptr + 1.U)
  }
}
